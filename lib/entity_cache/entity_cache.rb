class EntityCache
  configure :entity_cache

  attr_writer :persist_interval
  def persist_interval
    @persist_interval ||= Defaults.persist_interval
  end

  dependency :clock, Clock::UTC
  dependency :temporary_store, Store::Temporary
  dependency :persistent_store, Store::Persistent

  def self.build(subject, scope: nil, persist_interval: nil, persistent_store: nil)
    instance = new

    instance.configure(
      subject: subject,
      scope: scope,
      persist_interval: persist_interval,
      persistent_store: persistent_store
    )

    instance
  end

  def configure(subject:, scope: nil, persist_interval: nil, persistent_store: nil)
    unless persist_interval.nil?
      self.persist_interval = persist_interval
    end

    Store::Temporary.configure(self, subject, scope: scope)

    if persistent_store.nil?
      Store::Persistent::Null.configure(self, subject)
    else
      self.persistent_store = persistent_store
    end
  end

  def get(id)
    record = temporary_store.get(id)

    if record.nil?
      record = restore(id)
    end

    record
  end

  def put(id, entity, version, time: nil, persisted_version: nil, persisted_time: nil)
    time ||= clock.now

    if (version - persisted_version.to_i) >= persist_interval
      persistent_store.put(id, entity, version, time)

      persisted_version = version
      persisted_time = time
    end

    record = Record.build(
      id,
      entity,
      version,
      time,
      persisted_version: persisted_version,
      persisted_time: persisted_time
    )

    temporary_store.put(record)

    record
  end

  def restore(id)
    entity, version, time = persistent_store.get(id)

    return nil if entity.nil?

    record = Record.build(
      id,
      entity,
      version,
      time,
      persisted_version: version,
      persisted_time: time
    )

    temporary_store.put(record)

    record
  end
end

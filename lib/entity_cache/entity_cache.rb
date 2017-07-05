class EntityCache
  include Log::Dependency

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
    logger.trace { "Get entity (ID: #{id.inspect})" }

    record = temporary_store.get(id)

    if record.nil?
      record = restore(id)
    end

    if record.nil?
      logger.info { "Get entity failed; cache miss (ID: #{id.inspect}, #{Record::LogText.get(record)})" }
    else
      logger.info { "Get entity done (ID: #{id.inspect}, #{Record::LogText.get(record)})" }
    end

    record
  end

  def put(id, entity, version, time: nil, persisted_version: nil, persisted_time: nil)
    time ||= clock.now

    updated_persistent_store = false

    record = Record.build(id, entity, version, time)

    logger.trace { "Put entity (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect})" }

    if (version - persisted_version.to_i) >= persist_interval
      persistent_store.put(id, entity, version, time)

      persisted_version = version
      persisted_time = time
      updated_persistent_store = true
    end

    record.persisted_version = persisted_version
    record.persisted_time = persisted_time

    temporary_store.put(record)

    logger.info { "Put entity done (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect}, Updated Persistent Store: #{updated_persistent_store})" }

    record
  end

  def restore(id)
    logger.trace { "Restoring entity (ID: #{id.inspect})" }

    entity, version, time = persistent_store.get(id)

    if entity.nil?
      logger.debug { "Could not restore entity (ID: #{id.inspect})" }

      return nil
    end

    record = Record.build(
      id,
      entity,
      version,
      time,
      persisted_version: version,
      persisted_time: time
    )

    temporary_store.put(record)

    logger.debug { "Restored entity (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

    record
  end
end

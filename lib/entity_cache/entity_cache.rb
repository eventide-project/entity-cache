class EntityCache
  include Log::Dependency

  configure :entity_cache

  attr_writer :persist_interval
  def persist_interval
    @persist_interval ||= Defaults.persist_interval
  end

  dependency :clock, Clock::UTC
  dependency :internal_store, Store::Internal
  dependency :external_store, Store::External

  def self.build(subject, scope: nil, persist_interval: nil, external_store: nil, external_store_session: nil)
    instance = new

    instance.configure(
      subject: subject,
      scope: scope,
      persist_interval: persist_interval,
      external_store: external_store,
      external_store_session: external_store_session
    )

    instance
  end

  def configure(subject:, scope: nil, persist_interval: nil, external_store: nil, external_store_session: nil)
    external_store ||= Store::External::Null

    unless persist_interval.nil?
      self.persist_interval = persist_interval
    end

    Store::Internal.configure(self, subject, scope: scope)

    external_store.configure(self, subject, session: external_store_session)

    Clock::UTC.configure(self)
  end

  def get(id)
    logger.trace { "Get entity (ID: #{id.inspect})" }

    record = internal_store.get(id)

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

    updated_external_store = false

    record = Record.build(id, entity, version, time)

    logger.trace { "Put entity (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect})" }

    if persist?(version, persisted_version)
      external_store.put(id, entity, version, time)

      persisted_version = version
      persisted_time = time
      updated_external_store = true
    end

    record.persisted_version = persisted_version
    record.persisted_time = persisted_time

    internal_store.put(record)

    logger.info { "Put entity done (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect}, Updated External Store: #{updated_external_store})" }

    record
  end

  def restore(id)
    logger.trace { "Restoring entity (ID: #{id.inspect})" }

    entity, version, time = external_store.get(id)

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

    internal_store.put(record)

    logger.debug { "Restored entity (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

    record
  end

  def persist?(version, persisted_version)
    persisted_version ||= -1

    age_versions = version - persisted_version

    age_versions >= persist_interval
  end
end

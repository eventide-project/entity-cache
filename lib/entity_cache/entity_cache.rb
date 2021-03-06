class EntityCache
  include Configure
  include Dependency
  include Initializer
  include Log::Dependency

  configure :entity_cache

  attr_writer :persist_interval
  def persist_interval
    @persist_interval ||= Defaults.persist_interval
  end

  def entity_class
    subject.entity_class
  end

  def specifier
    subject.specifier
  end

  dependency :clock, Clock::UTC
  dependency :internal_store, Store::Internal
  dependency :external_store, Store::External

  initializer :subject

  def self.build(entity_class, specifier=nil, scope: nil, persist_interval: nil, external_store: nil, external_store_session: nil)
    subject = Subject.build({
      :entity_class => entity_class,
      :specifier => specifier
    })

    instance = new(subject)

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
    logger.trace(tag: :get) { "Get entity (ID: #{id.inspect})" }

    record = internal_store.get(id)

    if record.nil?
      record = restore(id)
    end

    if record.nil?
      logger.info(tags: [:get, :miss]) { "Cache miss getting entity (ID: #{id.inspect}, #{Record::LogText.get(record)})" }
    else
      logger.info(tags: [:get, :hit]) { "Get entity done (ID: #{id.inspect}, #{Record::LogText.get(record)})" }
    end

    record
  end

  def put(id, entity, version, time: nil, persisted_version: nil, persisted_time: nil)
    time ||= clock.now

    updated_external_store = false

    record = Record.build(id, entity, version, time)

    logger.trace(tag: :put) { "Put entity (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect})" }

    if persist?(version, persisted_version)
      external_store.put(id, entity, version, time)

      persisted_version = version
      persisted_time = time
      updated_external_store = true
    end

    record.persisted_version = persisted_version
    record.persisted_time = persisted_time

    internal_store.put(record)

    logger.info(tag: :put) { "Put entity done (ID: #{id.inspect}, #{Record::LogText.get(record)}, Persist Interval: #{persist_interval.inspect}, Updated External Store: #{updated_external_store})" }

    record
  end

  def restore(id)
    logger.trace(tag: :restore) { "Restoring entity (ID: #{id.inspect})" }

    entity, version, time = external_store.get(id)

    if entity.nil?
      logger.debug(tag: :restore) { "Could not restore entity. No entity record. (ID: #{id.inspect})" }

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

    logger.debug(tag: :restore) { "Restored entity (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

    record
  end

  def persist?(version, last_persisted_version)
    last_persisted_version ||= -1

    difference = version - last_persisted_version

    difference >= persist_interval
  end
end

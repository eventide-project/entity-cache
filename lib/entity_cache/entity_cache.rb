class EntityCache
  include Log::Dependency

  configure :entity_cache

  attr_accessor :persist_frequency

  dependency :clock, Clock::UTC
  dependency :persistent_store, Storage::Persistent
  dependency :temporary_store, Storage::Temporary

  def self.build(subject, persistent_store: nil, persist_frequency: nil)
    persistent_store ||= Defaults.persistent_store

    instance = new
    instance.persist_frequency = persist_frequency

    Clock::UTC.configure instance
    Storage::Temporary.configure instance, subject

    persistent_store.configure instance, subject

    instance
  end

  def get(id)
    logger.trace { "Reading cache (ID: #{id.inspect})" }

    record = temporary_store.get id
    record ||= restore id

    if record.nil?
      logger.info { "Cache miss (ID: #{id.inspect})" }
      return nil
    end

    logger.info { "Cache hit (ID: #{id.inspect}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time})" }

    record
  end

  def put(id, entity, version, persisted_version=nil, persisted_time=nil, time: nil)
    time ||= clock.iso8601(precision: 5)

    logger.trace { "Writing cache (ID: #{id}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time}, Persistent Version: #{persisted_version.inspect}, Persistent Time: #{persisted_time.inspect})" }

    record = Record.new id, entity, version, time, persisted_version, persisted_time

    put_record record

    logger.info { "Cache written (ID: #{id}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time}, Persistent Version: #{persisted_version.inspect}, Persistent Time: #{persisted_time.inspect})" }

    record
  end

  def put_record(record)
    if persist_frequency && record.versions_since_persisted >= persist_frequency
      persisted_time = clock.iso8601(precision: 5)

      persistent_store.put record.id, record.entity, record.version, persisted_time

      record.persisted_version = record.version
      record.persisted_time = persisted_time
    end

    temporary_store.put record
  end

  def restore(id)
    entity, persisted_version, persisted_time = persistent_store.get id

    return nil if entity.nil?

    version = persisted_version
    time = persisted_time

    put id, entity, version, persisted_version, persisted_time, time: time
  end
end

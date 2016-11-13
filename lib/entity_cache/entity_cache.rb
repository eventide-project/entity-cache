class EntityCache
  configure :entity_cache

  def write_behind_delay
    @write_behind_delay ||= Defaults.write_behind_delay
  end
  attr_writer :write_behind_delay

  dependency :clock, Clock::UTC
  dependency :logger, Telemetry::Logger
  dependency :persistent_store, Storage::Persistent
  dependency :temporary_store, Storage::Temporary

  def self.build(subject, persistent_store: nil, write_behind_delay: nil)
    persistent_store ||= Defaults.persistent_store

    instance = new
    instance.write_behind_delay = write_behind_delay

    Clock::UTC.configure instance
    Telemetry::Logger.configure instance
    Storage::Temporary.configure instance, subject

    persistent_store.configure instance, subject

    instance
  end

  def get(id)
    logger.opt_trace "Reading cache (ID: #{id.inspect})"

    record = temporary_store.get id
    record ||= restore id

    if record.nil?
      logger.opt_debug "Cache miss (ID: #{id.inspect})"
      return nil
    end

    logger.opt_debug "Cache hit (ID: #{id.inspect}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time})"

    record
  end

  def put(id, entity, version, persisted_version=nil, persisted_time=nil, time: nil)
    time ||= clock.iso8601

    logger.opt_trace "Writing cache (ID: #{id}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time}, Persistent Version: #{persisted_version.inspect}, Persistent Time: #{persisted_time.inspect})"

    record = Record.new id, entity, version, time, persisted_version, persisted_time

    put_record record

    logger.opt_debug "Cache written (ID: #{id}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time}, Persistent Version: #{persisted_version.inspect}, Persistent Time: #{persisted_time.inspect})"

    record
  end

  def put_record(record)
    if write_behind_delay && record.age >= write_behind_delay
      persisted_time = clock.iso8601

      puts "put_record"
      pp persistent_store
      puts


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

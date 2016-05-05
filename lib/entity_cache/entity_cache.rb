class EntityCache
  dependency :clock, Clock::UTC
  dependency :logger, Telemetry::Logger
  dependency :permanent_store, Storage::Permanent
  dependency :temporary_store, Storage::Temporary

  setting :write_behind_delay

  def self.build(permanent_store: nil)
    instance = new

    Clock::UTC.configure instance
    Telemetry::Logger.configure instance
    Storage::Temporary.configure instance

    permanent_store.configure instance if permanent_store

    instance
  end

  def get(id, include: nil)
    logger.opt_trace "Reading cache (ID: #{id.inspect}, Include: #{include.inspect})"

    record = temporary_store.get id
    record ||= restore id

    if record
      logger.opt_debug "Cache hit (ID: #{id.inspect}, Include: #{include.inspect}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time})"
    else
      logger.opt_debug "Cache miss (ID: #{id.inspect}, Include: #{include.inspect})"
    end

    record ||= Record::NoStream
    record.destructure include
  end

  def put(id, entity, version, permanent_version, permanent_time, time: nil)
    time ||= clock.iso8601

    logger.opt_trace "Writing cache (ID: #{id}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time}, Permanent Version: #{permanent_version.inspect}, Permanent Time: #{permanent_time})"

    record = Record.new id, entity, version, time, permanent_version, permanent_time

    put_record record

    logger.opt_debug "Cache written (ID: #{id}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Time: #{record.time}, Permanent Version: #{permanent_version.inspect}, Permanent Time: #{permanent_time})"

    record
  end

  def put_record(record)
    temporary_store.put record

    return if write_behind_delay.nil?

    if record.age >= write_behind_delay
      permanent_store.put record.id, record.entity, record.version
    end
  end

  def restore(id)
    entity, permanent_version, permanent_time = permanent_store.get id

    return nil if entity.nil?

    version = permanent_version
    time = permanent_time

    put id, entity, version, permanent_version, permanent_time, time: time
  end
end

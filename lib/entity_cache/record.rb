class EntityCache
  Record = Struct.new(
    :id,
    :entity,
    :version,
    :time,
    :persisted_version,
    :persisted_time
  )

  class Record
    def self.build(id, entity, version, time, persisted_version: nil, persisted_time: nil)
      new(id, entity, version, time, persisted_version, persisted_time)
    end

    def self.destructure(instance, includes=nil)
      Destructure.(instance, includes)
    end

    def age_milliseconds
      Clock::UTC.elapsed_milliseconds(time, Clock::UTC.now)
    end

    def persisted_age_milliseconds
      return nil if persisted_time.nil?

      Clock::UTC.elapsed_milliseconds(
        persisted_time,
        time
      )
    end

    def persisted_age_versions
      return nil if persisted_version.nil?

      version - persisted_version
    end
  end
end

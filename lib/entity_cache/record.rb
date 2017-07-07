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
    dependency :clock, Clock::UTC

    def configure
      Clock::UTC.configure(self)
    end

    def self.build(id, entity, version, time, persisted_version: nil, persisted_time: nil)
      instance = new(id, entity, version, time, persisted_version, persisted_time)
      instance.configure
      instance
    end

    def self.destructure(instance, includes=nil)
      Destructure.(instance, includes)
    end

    def age_milliseconds
      Clock::UTC.elapsed_milliseconds(time, clock.now)
    end

    def persisted_age_milliseconds
      if persisted_time.nil?
        nil
      else
        Clock::UTC.elapsed_milliseconds(
          persisted_time,
          time
        )
      end
    end

    def persisted_age_versions
      if persisted_version.nil?
        nil
      else
        version - persisted_version
      end
    end
  end
end

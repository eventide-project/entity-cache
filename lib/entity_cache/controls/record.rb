class EntityCache
  module Controls
    module Record
      def self.example(entity=nil, id: nil, version: nil, time: nil, persisted: nil, persisted_version: nil, persisted_time: nil)
        entity ||= self.entity
        id ||= self.id
        version ||= self.version
        time ||= self.time

        unless persisted == false
          persisted_version ||= self.persisted_version
        end

        unless persisted == false
          persisted_time ||= self.persisted_time
        end

        EntityCache::Record.new(
          id,
          entity,
          version,
          time,
          persisted_version,
          persisted_time
        )
      end

      def self.id
        Entity.id
      end

      def self.entity
        Entity.example
      end

      def self.time
        Time::Offset::Raw.example(11)
      end

      def self.version
        Version::Current.example
      end

      def self.persisted_time
        Time::Offset::Raw.example(1)
      end

      def self.persisted_version
        Version::Previous.example
      end
    end
  end
end

class EntityCache
  module Substitute
    def self.build
      EntityCache.build
    end

    class EntityCache < EntityCache
      def self.build
        new
      end

      def add(id, entity, version=nil, time: nil, persisted_version: nil, persisted_time: nil)
        version ||= 0
        persisted_version ||= version
        time ||= clock.now
        persisted_time ||= time

        record = Record.build(
          id,
          entity,
          version,
          time,
          persisted_version: persisted_version,
          persisted_time: persisted_time
        )

        internal_store.put(record)
      end

      def put(id, entity, version, time: nil, persisted_version: nil, persisted_time: nil)
        time ||= clock.now

        record = Record.build(
          id,
          entity,
          version,
          time,
          persisted_version: persisted_version,
          persisted_time: persisted_time
        )

        put_records << record

        record
      end

      def put?(&blk)
        return put_records.any? if blk.nil?

        put_records.any? do |record|
          blk.(record)
        end
      end

      def put_records
        @put_records ||= []
      end
    end
  end
end

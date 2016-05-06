class EntityCache
  module Substitute
    def self.build
      EntityCache.build
    end

    class EntityCache < EntityCache
      def self.build
        instance = new
        Telemetry::Logger.configure instance
        instance
      end

      def add(id, entity, version=nil, persisted_version: nil)
        version ||= 0

        time = Clock::UTC.iso8601

        persisted_version ||= version

        record = Record.new id, entity, version, time, persisted_version, time

        temporary_store.put record
      end

      def put_record(record)
        put_records << record
      end

      def put_records
        @put_records ||= []
      end

      module Assertions
        def put?(&blk)
          return put_records.any? if blk.nil?

          put_records.any? do |record|
            blk.(record.id, record.entity, record.version, record.persisted_version)
          end
        end
      end
    end
  end
end

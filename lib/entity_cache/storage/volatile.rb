module EntityCache
  module Storage
    class Volatile
      attr_reader :subject

      dependency :clock, Clock::UTC
      dependency :logger, Telemetry::Logger

      def initialize(subject)
        @subject = subject
      end

      def self.build(subject)
        instance = new subject
        Clock::UTC.configure instance
        Telemetry::Logger.configure instance
        instance
      end

      def self.configure(receiver, subject, scope: nil, attr_name: nil)
        attr_name ||= :volatile_storage

        instance = Factory.(subject, scope: scope)
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def get(id)
        logger.opt_trace "Getting record from volatile storage (ID: #{id.inspect})"

        record = get_record id

        if record
          logger.opt_debug "Retrieved record from volatile storage (ID: #{id.inspect}, Entity Class: #{record.entity.class.name}, Version: #{record.version}, Time: #{record.time})"
        else
          logger.opt_debug "Record was not found in volatile storage (ID: #{id.inspect})"
        end

        record
      end

      def get_record(id)
        records[id]
      end

      def put(id, entity, version, non_volatile_version=nil)
        time = clock.iso8601

        logger.opt_trace "Putting record into volatile storage (ID: #{id.inspect}, Entity Class: #{entity.class.name}, Version: #{version}, Time: #{time})"

        record = Record.new id, entity, version, non_volatile_version, time

        put_record record

        logger.opt_debug "Put record into volatile storage (ID: #{id.inspect}, Entity Class: #{entity.class.name}, Version: #{version}, Time: #{time})"

        record
      end

      def put_record(record)
        records[record.id] = record
      end

      abstract :records
    end
  end
end

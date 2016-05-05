class EntityCache
  module Storage
    class Temporary
      attr_reader :subject

      dependency :logger, Telemetry::Logger

      def initialize(subject)
        @subject = subject
      end

      def self.build(subject)
        instance = new subject
        Telemetry::Logger.configure instance
        instance
      end

      def self.configure(receiver, subject, scope: nil, attr_name: nil)
        attr_name ||= :temporary_store

        instance = Factory.(subject, scope: scope)
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def get(id)
        records[id]
      end

      def put(record)
        records[record.id] = record
      end

      abstract :records
    end
  end
end

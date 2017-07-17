class EntityCache
  module Store
    class Internal
      include Log::Dependency

      attr_accessor :subject

      def self.build(subject)
        instance = new
        instance.subject = subject
        instance
      end

      def self.configure(receiver, subject, scope: nil, attr_name: nil)
        attr_name ||= :internal_store

        instance = Build.(subject, scope: scope)
        receiver.public_send("#{attr_name}=", instance)
        instance
      end

      abstract :records

      def get(id)
        logger.trace { "Getting Entity (ID: #{id.inspect})" }

        record = records[id]

        logger.debug { "Get entity done (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

        record
      end

      def put(record)
        id = record.id

        logger.trace { "Putting entity (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

        records[id] = record

        logger.trace { "Put entity done (ID: #{id.inspect}, #{Record::LogText.get(record)})" }

        record
      end
    end
  end
end

class EntityCache
  module Storage
    class Temporary
      include Log::Dependency

      attr_reader :subject

      def initialize(subject)
        @subject = subject
      end

      def self.build(subject)
        instance = new subject
        instance
      end

      def self.configure(receiver, subject, scope: nil, attr_name: nil)
        attr_name ||= :temporary_store

        instance = Build.(subject, scope: scope)
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

      module Assertions
        def empty?
          records.empty?
        end

        def put?(&block)
          block ||= proc { true }

          records.any? do |_, record|
            block.(record)
          end
        end
      end

      module Substitute
        def self.build
          Scope::Exclusive.build :substitute
        end
      end
    end
  end
end

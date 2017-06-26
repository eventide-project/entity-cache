class EntityCache
  class Record
    module Destructure
      def self.call(record, includes=nil)
        record ||= NoStream.record

        return record.entity if includes.nil?

        return_values = Array(includes).map do |attribute|
          record.public_send(attribute)
        end

        return record.entity, *return_values
      end

      module NoStream
        def self.record
          @record ||= build_record
        end

        def self.build_record
          record = Record.new
          record.version = MessageStore::NoStream.name
          record
        end
      end
    end
  end
end

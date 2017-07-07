class EntityCache
  class Record
    module Transformer
      def self.raw_data(instance)
        raw_data = instance.to_h

        entity = raw_data.delete(:entity)
        copied_entity = Transform::Copy.(entity)

        raw_data[:entity] = copied_entity

        raw_data
      end

      def self.instance(raw_data)
        instance = Record.new

        raw_data.each do |attribute, value|
          instance.public_send("#{attribute}=", value)
        end

        instance
      end
    end
  end
end

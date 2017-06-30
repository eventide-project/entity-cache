class EntityCache
  module Controls
    module Entity
      def self.example
        Example.new(id, some_attr, other_attr)
      end

      def self.id
        ID.example
      end

      def self.some_attr
        'some-value'
      end

      def self.other_attr
        'other-value'
      end

      Example = Struct.new(:id, :some_attr, :other_attr)

      class Example
        module Transformer
          def self.raw_data(instance)
            instance.to_a
          end

          def self.instance(raw_data)
            Example.new(*raw_data)
          end
        end
      end
    end
  end
end

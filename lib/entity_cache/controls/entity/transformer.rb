class EntityCache
  module Controls
    module Entity
      module Transformer
        def self.example
          some_attr = 'some-value'
          other_attr = 'other-value'

          Example.new(some_attr, other_attr)
        end

        class Example < NoTransformer::Example
          module Transformer
            def self.instance(raw_data)
              Example.new(*raw_data)
            end

            def self.raw_data(instance)
              [instance.some_attr, instance.other_attr]
            end
          end
        end
      end
    end
  end
end

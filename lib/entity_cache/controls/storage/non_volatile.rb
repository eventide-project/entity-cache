class EntityCache
  module Controls
    module Storage
      module NonVolatile
        def self.example
          ExampleClass.build
        end

        class ExampleClass
          include EntityCache::Storage::NonVolatile

          def get(id)
            _, entity, version = data[id]

            return entity, version
          end

          def put(id, entity, version)
            data[id] = [id, entity, version]
          end

          def data
            @data ||= {}
          end

          module Assertions
            def stored?(&blk)
              data.each_value.any? do |id, entity, version|
                blk.(id, entity, version)
              end
            end
          end
        end
      end
    end
  end
end

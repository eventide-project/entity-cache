class EntityCache
  module Controls
    module Storage
      module Permanent
        class Example
          include EntityCache::Storage::Permanent

          def get(id)
            entity, version, time = stored_records[id]

            return entity, version, time
          end

          def put(id, entity, version, time)
            stored_records[id] = [entity, version, time]
          end

          def stored_records
            @stored_records ||= {}
          end

          module Assertions
            def stored?(id, entity, version, time)
              stored_records[id] == [entity, version, time]
            end
          end
        end

        def self.example
          Example.build
        end
      end
    end
  end
end

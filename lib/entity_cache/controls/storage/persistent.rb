class EntityCache
  module Controls
    module Storage
      module Persistent
        class Example
          include EntityCache::Storage::Persistent

          def get(id)
            entity, version, time = records[id]

            return entity, version, time
          end

          def put(id, entity, version, time)
            records[id] = [entity, version, time]
          end

          def records
            @records ||= {}
          end

          module Assertions
            def stored?(id, entity, version, time)
              records[id] == [entity, version, time]
            end
          end
        end

        def self.example
          Example.build :some_subject
        end

        def self.substitute
          SubstAttr::Substitute.build Example
        end
      end
    end
  end
end

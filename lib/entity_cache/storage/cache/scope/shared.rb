class EntityCache
  module Storage
    class Cache
      module Scope
        class Shared < Cache
          def records
            records_registry[subject] ||= {}
          end

          def records_registry
            @@records_registry ||= {}
          end
        end
      end
    end
  end
end

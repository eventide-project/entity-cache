class EntityCache
  module Storage
    class Volatile
      module Scope
        class Shared < Volatile
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

class EntityCache
  module Storage
    class Temporary
      module Scope
        class Shared < Temporary
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

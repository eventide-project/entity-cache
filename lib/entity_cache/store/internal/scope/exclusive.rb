class EntityCache
  module Store
    class Internal
      module Scope
        class Exclusive < Internal
          def records
            @records ||= {}
          end
        end
      end
    end
  end
end

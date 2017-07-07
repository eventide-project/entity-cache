class EntityCache
  module Store
    class Temporary
      module Scope
        class Exclusive < Temporary
          def records
            @records ||= {}
          end
        end
      end
    end
  end
end

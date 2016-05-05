class EntityCache
  module Storage
    class Cache
      module Scope
        class Exclusive < Cache
          def records
            @records ||= {}
          end
        end
      end
    end
  end
end

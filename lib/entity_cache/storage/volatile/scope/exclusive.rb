module EntityCache
  module Storage
    class Volatile
      module Scope
        class Exclusive < Volatile
          def records
            @records ||= {}
          end
        end
      end
    end
  end
end

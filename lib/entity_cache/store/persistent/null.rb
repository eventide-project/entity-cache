class EntityCache
  module Store
    module Persistent
      class Null
        include Store::Persistent

        def get(id)
        end

        def put(id, entity, version, time)
        end
      end
    end
  end
end

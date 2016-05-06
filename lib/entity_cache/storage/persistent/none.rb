class EntityCache
  module Storage
    module Persistent
      class None
        include Persistent

        def get(*)
        end

        def put(*)
        end
      end
    end
  end
end

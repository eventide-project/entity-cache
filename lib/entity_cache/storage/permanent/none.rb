class EntityCache
  module Storage
    module Permanent
      class None
        include Permanent

        def get(*)
        end

        def put(*)
        end
      end
    end
  end
end

class EntityCache
  module Store
    module External
      class Null
        include Store::External

        def get(id)
        end

        def put(id, entity, version, time)
        end
      end
    end
  end
end

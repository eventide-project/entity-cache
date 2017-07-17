class EntityCache
  module Store
    module External
      module Telemetry
        Data = Struct.new(:id, :entity, :version, :time)

        class Sink
          include ::Telemetry::Sink

          record :put
          record :get
        end
      end
    end
  end
end

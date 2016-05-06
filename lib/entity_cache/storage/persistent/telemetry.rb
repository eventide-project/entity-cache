class EntityCache
  module Storage
    module Persistent
      module Telemetry
        def self.sink
          Sink.new
        end

        Data = Struct.new :id, :entity, :version, :time

        class Sink
          include ::Telemetry::Sink

          record :get
          record :put

          def retrieved?(&blk)
            return get_records if blk.nil?

            recorded_get? do |record|
              data = record.data
              blk.call(data.id, data.entity, data.version, data.time)
            end
          end

          def stored?(&blk)
            return put_records if blk.nil?

            recorded_put? do |record|
              data = record.data
              blk.call(data.id, data.entity, data.version, data.time)
            end
          end
        end
      end
    end
  end
end

class EntityCache
  module Storage
    module Permanent
      module Substitute
        def self.build
          substitute = Permanent.build
          sink = Permanent.register_telemetry_sink substitute
          substitute.sink = sink
          substitute
        end

        class Permanent
          attr_accessor :sink

          include Storage::Permanent

          def get(id)
            entity, version, time = records[id]
            return entity, version,time
          end

          def put(*)
          end

          def add(id, entity, version, time)
            records[id] ||= [entity, version, time]
          end

          def records
            @records ||= {}
          end

          module Assertions
            def retrieved?(&blk)
              sink.retrieved? &blk
            end

            def stored?(&blk)
              sink.stored? &blk
            end
          end
        end
      end
    end
  end
end

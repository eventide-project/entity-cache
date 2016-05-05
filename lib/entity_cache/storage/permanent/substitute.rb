class EntityCache
  module Storage
    module Permanent
      module Substitute
        def self.build
          substitute = Permanent.build
          sink = Permanent.register_telemetry_sink substitute
          substitute.sink = sink
        end

        module Assertions
          def retrieved?(&blk)
            sink.retrieved? &blk
          end

          def stored?(&blk)
            sink.stored? &blk
          end
        end

        class Permanent
          attr_accessor :sink

          include Storage::Permanent

          def get(*)
          end

          def put(*)
          end
        end
      end
    end
  end
end

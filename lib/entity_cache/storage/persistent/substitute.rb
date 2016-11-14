class EntityCache
  module Storage
    module Persistent
      module Substitute
        def self.build
          substitute = Persistent.build :substitute
          sink = Persistent.register_telemetry_sink substitute
          substitute.sink = sink
          substitute
        end

        class Persistent
          attr_accessor :sink

          include Storage::Persistent

          def get(id)
            entity, version, time = records[id]
            return entity, version,time
          end

          def put(*)
          end

          def add(id, entity, version, time=nil)
            time ||= Clock::UTC.iso8601(precision: 5)
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

            def stored_nothing?
              sink.put_records.empty?
            end
          end
        end
      end
    end
  end
end

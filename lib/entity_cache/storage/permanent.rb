class EntityCache
  module Storage
    module Permanent
      def self.included(cls)
        cls.class_exec do
          dependency :logger, ::Telemetry::Logger
          dependency :telemetry, ::Telemetry

          extend Build
          extend RegisterTelemetrySink

          prepend Get
          prepend Put

          abstract :get
          abstract :put
        end
      end

      module Get
        def get(id)
          logger.opt_trace "Getting entity (ID: #{id.inspect})"

          entity, version, time = super

          telemetry.record :get, Telemetry::Data.new(id, entity, version, time)

          logger.opt_debug "Got entity (ID: #{id.inspect}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time.inspect})"

          return entity, version, time
        end
      end

      module Put
        def put(id, entity, version, time=nil)
          time ||= clock.iso8601

          logger.opt_trace "Putting entity (ID: #{id.inspect}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time.inspect})"

          super

          telemetry.record :put, Telemetry::Data.new(id, entity, version, time)

          logger.opt_debug "Put entity (ID: #{id.inspect}, Entity Class: #{entity.class.name}, Version: #{version.inspect}, Time: #{time.inspect})"
        end
      end

      module Build
        def build
          instance = new
          ::Telemetry::Logger.configure instance
          ::Telemetry.configure instance
          instance
        end
      end

      module RegisterTelemetrySink
        def register_telemetry_sink(storage)
          sink = Telemetry.sink
          storage.telemetry.register sink
          sink
        end
      end

      module Telemetry
        def self.sink
          Sink.new
        end

        Data = Struct.new :id, :entity, :version, :time

        class Sink
          include ::Telemetry::Sink

          record :get
          record :put

          module Assertions
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
end

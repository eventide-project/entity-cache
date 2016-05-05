class EntityCache
  module Storage
    module Permanent
      def self.included(cls)
        cls.class_exec do
          dependency :clock, Clock::UTC
          dependency :logger, ::Telemetry::Logger
          dependency :telemetry, ::Telemetry

          extend Build
          extend RegisterTelemetrySink

          prepend Get
          prepend Put

          virtual :configure_dependencies
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
          Clock::UTC.configure instance
          ::Telemetry::Logger.configure instance
          ::Telemetry.configure instance
          instance.configure_dependencies
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
    end
  end
end

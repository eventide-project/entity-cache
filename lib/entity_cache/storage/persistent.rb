class EntityCache
  module Storage
    module Persistent
      def self.included(cls)
        cls.class_exec do
          include Log::Dependency

          extend Build
          extend RegisterTelemetrySink

          dependency :telemetry, ::Telemetry

          initializer :subject

          virtual :configure
          abstract :get
          abstract :put

          prepend Configure
          prepend Get
          prepend Put
        end
      end

      module Configure
        def configure(**)
          super

          ::Telemetry.configure(self)
        end
      end

      module Get
        def get(id)
          logger.trace { "Getting entity (ID: #{id.inspect})" }

          entity, version, time = super

          telemetry.record(:get, Telemetry::Data.new(id, entity, version, time))

          logger.debug { "Get entity done (ID: #{id.inspect}, Entity Class: #{entity.class}, Version: #{version.inspect}, Time: #{Clock.iso8601(time)})" }

          return entity, version, time
        end
      end

      module Put
        def put(id, entity, version, time)
          logger.trace { "Putting entity (ID: #{id.inspect}, Entity Class: #{entity.class}, Version: #{version.inspect}, Time: #{Clock.iso8601(time)})" }

          super

          telemetry.record(:put, Telemetry::Data.new(id, entity, version, time))

          logger.debug { "Put entity done (ID: #{id.inspect}, Entity Class: #{entity.class}, Version: #{version.inspect}, Time: #{Clock.iso8601(time)})" }
        end
      end

      module Build
        def build(subject, session: nil)
          instance = new(subject)
          instance.configure(session: session)
          instance
        end
      end

      module RegisterTelemetrySink
        def register_telemetry_sink(persistent_store)
          sink = Telemetry::Sink.new
          persistent_store.telemetry.register(sink)
          sink
        end
      end
    end
  end
end

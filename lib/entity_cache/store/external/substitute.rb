class EntityCache
  module Store
    module External
      module Substitute
        def self.build
          External.build
        end

        class External
          include Store::External

          attr_accessor :telemetry_sink

          def self.build
            instance = new(subject)
            instance.configure
            instance
          end

          def configure(session: nil)
            self.telemetry_sink = self.class.register_telemetry_sink(self)
          end

          def get(id)
            record = get_records[id]

            if record
              return record.entity, record.version, record.time
            end
          end

          def get_records
            @get_records ||= {}
          end

          def add(id, entity, version, time)
            record = Record.new(id, entity, version, time)

            get_records[id] = record

            record
          end

          def put(*)
          end

          def put?(&block)
            block ||= proc { true }

            telemetry_sink.recorded_put? do |record|
              data = record.data

              block.(data.id, data.entity, data.version, data.time)
            end
          end

          def self.subject
            :substitute
          end
        end
      end
    end
  end
end

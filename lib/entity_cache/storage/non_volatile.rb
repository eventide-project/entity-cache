class EntityCache
  module Storage
    module NonVolatile
      def self.included(cls)
        cls.class_exec do
          dependency :logger, Telemetry::Logger

          abstract :get
          abstract :put

          virtual :configure_dependencies
          virtual :max_age
        end

        cls.extend Build
      end

      def get_record(id)
        logger.opt_trace "Getting record from non-volatile storage (ID: #{id.inspect}, Storage Class: #{self.class.name})"

        entity, version = get id

        if entity.nil?
          logger.opt_debug "Record was not found in non-volatile storage (ID: #{id.inspect}, Storage Class: #{self.class.name})"
          return nil
        end

        record = Record.build id, entity, non_volatile_version: version
        logger.opt_debug "Retrieved record from non-volatile storage (ID: #{id.inspect}, Storage Class: #{self.class.name}, Entity Class: #{record.entity.class.name}, Version: #{record.version})"
        record
      end

      def put_record(record)
        id, entity, version = record.id, record.entity, record.version

        logger.opt_trace "Putting record into non-volatile storage (ID: #{id.inspect}, Storage Class: #{self.class.name}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Non Volatile Version: #{record.non_volatile_version.inspect}, Time: #{record.time})"

        put id, entity, version

        record.non_volatile_version = record.version

        logger.opt_debug "Put record into non-volatile storage (ID: #{id.inspect}, Storage Class: #{self.class.name}, Entity Class: #{record.entity.class.name}, Version: #{record.version.inspect}, Non Volatile Version: #{record.non_volatile_version.inspect}, Time: #{record.time})"
      end

      module Build
        def build
          instance = new
          Telemetry::Logger.configure instance
          instance.configure_dependencies
          instance
        end
      end
    end
  end
end

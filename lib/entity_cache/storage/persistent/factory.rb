class EntityCache
  module Storage
    module Persistent
      module Factory
        def self.call(subject, implementation: nil)
          implementation ||= Defaults.implementation

          cls = implementation_class implementation

          instance = cls.build subject
          instance
        end

        def self.implementation_class(name)
          implementations.fetch name do
            *names, final_name = implementations.keys
            names = "#{names * ', '} or #{final_name}"

            error_message =  %{Implementation "#{name}" is unknown. It must be one of: #{names}.}

            logger.error error_message
            raise Error, error_message
          end
        end

        def self.implementations
          @implementations ||= {
            :none => None
          }
        end

        def self.logger
          @logger ||= ::Telemetry::Logger.get self
        end
      end
    end
  end
end

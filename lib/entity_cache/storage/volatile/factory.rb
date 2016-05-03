module EntityCache
  module Storage
    class Volatile
      module Factory
        def self.call(subject, scope: nil)
          scope ||= Scope::Defaults::Name.get

          scope_class = self.scope_class scope

          scope_class.build subject
        end

        def self.scope_class(scope_name)
          scope_class = scopes[scope_name]

          if scope_class.nil?
            error_message = %{Scope "#{scope_name}" is unknown. It must be one of: #{scopes.keys * ', '})}
            logger.error error_message
            raise Scope::Error, error_message
          end

          scope_class
        end

        def self.scopes
          @scopes ||= {
            :exclusive => Scope::Exclusive,
            :shared => Scope::Shared
          }
        end

        def self.logger
          @logger ||= Telemetry::Logger.get self
        end
      end
    end
  end
end

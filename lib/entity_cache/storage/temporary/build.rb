class EntityCache
  module Storage
    class Temporary
      module Build
        def self.call(subject, scope: nil)
          scope ||= Scope::Defaults.name

          scope_class = scope_class(scope)

          scope_class.build(subject)
        end

        def self.scope_class(scope_name)
          scope_class = scopes[scope_name]

          if scope_class.nil?
            *scopes, final_scope = self.scopes.keys
            scopes = "#{scopes * ', '} or #{scope_name}"

            error_message = %{Scope "#{scope_name}" is unknown. It must be one of: #{scopes}}

            logger.error(error_message)
            raise Scope::Error, error_message
          end

          scope_class
        end

        def self.scopes
          @scopes ||= {
            :exclusive => Scope::Exclusive,
            :thread => Scope::Thread,
            :global => Scope::Global
          }
        end

        def self.logger
          @logger ||= Log.get(self)
        end
      end
    end
  end
end

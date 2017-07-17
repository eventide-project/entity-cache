class EntityCache
  module Store
    class Internal
      module Build
        def self.call(subject, scope: nil)
          scope ||= Defaults.scope

          cls = scope_class(scope)

          cls.build(subject)
        end

        def self.default_scope_class
          scope_class(Defaults.scope)
        end

        def self.scope_class(scope)
          scopes.fetch(scope) do
            *scopes, final_scope = self.scopes.keys

            scope_list = <<~TEXT
            #{scopes.map(&:inspect) * ', '} or #{final_scope.inspect}
            TEXT

            error_message = %{Scope #{scope.inspect} is unknown. It must be one of: #{scope_list}}

            logger.error(error_message)
            raise ScopeError, error_message
          end
        end

        def self.scopes
          @scopes ||= {
            :exclusive => Scope::Exclusive,
            :global => Scope::Global,
            :thread => Scope::Thread
          }
        end

        def self.logger
          @logger ||= Log.get(self)
        end

        ScopeError = Class.new(StandardError)
      end
    end
  end
end

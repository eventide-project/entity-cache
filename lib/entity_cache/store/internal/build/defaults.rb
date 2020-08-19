class EntityCache
  module Store
    class Internal
      module Build
        module Defaults
          def self.scope
            Scope.get
          end

          module Scope
            def self.get
              value = ENV.fetch(env_var, default)
              value.to_sym
            end

            def self.env_var
              'ENTITY_CACHE_SCOPE'
            end

            def self.default
              if not RUBY_ENGINE == 'mruby'
                'thread'
              else
                'exclusive'
              end
            end
          end
        end
      end
    end
  end
end

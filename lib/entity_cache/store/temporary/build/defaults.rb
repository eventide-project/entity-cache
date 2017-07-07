class EntityCache
  module Store
    class Temporary
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
              'thread'
            end
          end
        end
      end
    end
  end
end

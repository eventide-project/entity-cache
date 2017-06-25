class EntityCache
  module Storage
    class Temporary
      module Scope
        module Defaults
          def self.name
            Name.get
          end

          module Name
            def self.get
              value = env_var_value || self.value
              value.to_sym
            end

            def self.env_var_value
              ENV[env_var_name]
            end

            def self.env_var_name
              'ENTITY_CACHE_SCOPE'
            end

            def self.value
              'thread'
            end
          end
        end
      end
    end
  end
end

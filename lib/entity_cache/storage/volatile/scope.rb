module EntityCache
  module Storage
    class Volatile
      module Scope
        Error = Class.new StandardError

        module Defaults
          module Name
            def self.get
              value = env_var_value || self.value
              value.to_sym
            end

            def self.env_var_value
              ENV[env_var_name]
            end

            def self.env_var_name
              'VOLATILE_ENTITY_CACHE_SCOPE'
            end

            def self.value
              'shared'
            end
          end
        end
      end
    end
  end
end

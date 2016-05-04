module EntityCache
  module Controls
    module Record
      def self.example
        Volatile.example
      end

      module NonVolatile
        def self.example
          id = ::Controls::ID.get
          entity = Entity.example
          version = Version.example

          EntityCache::Record.build id, entity, non_volatile_version: version
        end
      end

      module Volatile
        def self.example
          id = ::Controls::ID.get
          entity = Entity.example
          version = Version.example
          time = ::Controls::Time.reference

          EntityCache::Record.build id, entity, version: version, time: time
        end
      end
    end
  end
end

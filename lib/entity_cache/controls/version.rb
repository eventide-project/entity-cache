class EntityCache
  module Controls
    module Version
      def self.example
        11
      end

      module Age
        def self.example
          Version.example - Permanent.example
        end
      end

      module NoStream
        def self.example
          EntityCache::Record::NoStream.version
        end
      end

      module Permanent
        def self.example
          1
        end
      end
    end
  end
end

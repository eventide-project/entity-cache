class EntityCache
  module Controls
    module PersistInterval
      module Exceeds
        def self.example
          Version.example - Version::Persistent.example
        end

        module NoStream
          def self.example
            Version.example
          end
        end
      end

      module Within
        def self.example
          Exceeds.example + 1
        end

        module NoStream
          def self.example
            Exceeds::NoStream.example + 1
          end
        end
      end
    end
  end
end

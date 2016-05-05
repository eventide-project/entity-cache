class EntityCache
  module Controls
    module WriteBehindDelay
      module Exceeds
        def self.example
          Version.example - Version::Permanent.example
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

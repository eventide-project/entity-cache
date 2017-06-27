class EntityCache
  module Controls
    module Storage
      module Persistent
        module NotImplemented
          def self.example
            subject = Subject.example

            Example.new(subject)
          end

          class Example
            include EntityCache::Storage::Persistent
          end
        end
      end
    end
  end
end

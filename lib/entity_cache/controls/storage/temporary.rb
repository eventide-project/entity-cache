class EntityCache
  module Controls
    module Storage
      module Temporary
        def self.example
          subject = Subject.example

          EntityCache::Storage::Temporary::Scope::Exclusive.build(subject)
        end
      end
    end
  end
end

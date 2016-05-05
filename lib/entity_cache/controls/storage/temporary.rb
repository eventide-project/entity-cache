class EntityCache
  module Controls
    module Storage
      module Temporary
        def self.example
          EntityCache::Storage::Temporary::Scope::Exclusive.build :some_subject
        end
      end
    end
  end
end

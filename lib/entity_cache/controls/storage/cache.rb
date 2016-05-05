class EntityCache
  module Controls
    module Storage
      module Cache
        def self.example
          EntityCache::Storage::Cache::Scope::Exclusive.build :some_subject
        end
      end
    end
  end
end

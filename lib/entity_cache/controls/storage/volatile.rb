module EntityCache
  module Controls
    module Storage
      module Volatile
        def self.example
          EntityCache::Storage::Volatile::Scope::Exclusive.build :some_subject
        end
      end
    end
  end
end

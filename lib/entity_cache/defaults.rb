class EntityCache
  module Defaults
    def self.persistent_store
      Storage::Persistent::None
    end
  end
end

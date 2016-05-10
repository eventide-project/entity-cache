class EntityCache
  module Defaults
    def self.persistent_store
      Storage::Persistent::None
    end

    def self.write_behind_delay
      10
    end
  end
end

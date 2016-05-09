class EntityCache
  module Defaults
    def self.persistent_store
      'none'
    end

    def self.write_behind_delay
      10
    end
  end
end

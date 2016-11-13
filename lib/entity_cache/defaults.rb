class EntityCache
  module Defaults
    def self.persistent_store
      Storage::Persistent::None
    end

    def self.write_behind_delay
      env_write_behind_delay = ENV['ENTITY_CACHE_WRITE_BEHIND_DELAY']

      if env_write_behind_delay.nil?
        return 100
      end

      env_write_behind_delay.to_i
    end
  end
end

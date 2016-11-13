class EntityCache
  class Settings < ::Settings
    def self.data_source
      if File.exist? path
        path
      else
        {}
      end
    end

    def self.path
      'settings/entity_cache.json'
    end

    def self.instance
      @instance ||= build
    end

    def self.names
      [
        :write_behind_delay
      ]
    end
  end
end

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
      @path ||= 'settings/entity_cache.json'
    end

    def self.path=(val)
      @path = val
    end

    def self.instance
      @instance ||= build
    end
  end
end

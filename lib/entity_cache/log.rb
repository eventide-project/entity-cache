class EntityCache
  class Log < ::Log
    def tag!(tags)
      tags << :entity_cache
      tags << :library
      tags << :verbose
    end
  end
end

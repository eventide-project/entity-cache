class EntityCache
  class Log < ::Log
    def tag!(tags)
      tags << :cache
    end
  end
end

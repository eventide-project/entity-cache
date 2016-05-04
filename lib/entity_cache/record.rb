class EntityCache
  class Record
    attr_accessor :id
    attr_accessor :entity
    attr_accessor :non_volatile_version
    attr_accessor :time
    attr_accessor :version

    def self.build(id, entity, version: nil, time: nil, non_volatile_version: nil)
      instance = new
      instance.id = id
      instance.entity = entity
      instance.version = version if version
      instance.time = time if time
      instance.non_volatile_version = non_volatile_version if non_volatile_version
      instance
    end

    def self.initial
      new
    end

    def ==(other)
      id == other.id &&
        entity == other.entity &&
        non_volatile_version == other.non_volatile_version &&
        time == other.time &&
        version == other.version
    end
  end
end

module EntityCache
  class Record
    attr_reader :id
    attr_reader :entity
    attr_accessor :non_volatile_version
    attr_accessor :time
    attr_accessor :version

    def initialize(id, entity)
      @id = id
      @entity = entity
    end

    def self.build(id, entity, version: nil, time: nil, non_volatile_version: nil)
      instance = new id, entity
      instance.version = version if version
      instance.time = time if time
      instance.non_volatile_version = non_volatile_version if non_volatile_version
      instance
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

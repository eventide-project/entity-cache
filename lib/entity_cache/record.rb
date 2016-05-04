module EntityCache
  class Record
    attr_reader :id
    attr_reader :entity
    attr_reader :version
    attr_reader :non_volatile_version
    attr_reader :time

    def initialize(id, entity, version, non_volatile_version, time)
      @id = id
      @entity = entity
      @version = version
      @non_volatile_version = non_volatile_version
      @time = time
    end
  end
end

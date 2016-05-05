class EntityCache
  module Controls
    module Record
      def self.example(id=nil, version: nil, permanent_version: nil)
        id ||= ::Controls::ID.get
        entity = Entity.example
        version ||= Version.example
        time = ::Controls::Time.reference

        permanent_version ||= Version.example
        permanent_time = time

        EntityCache::Record.new id, entity, version, time, permanent_version, permanent_time
      end
    end
  end
end

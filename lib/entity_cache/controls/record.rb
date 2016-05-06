class EntityCache
  module Controls
    module Record
      def self.example(id=nil, version: nil, persisted_version: nil)
        id ||= ::Controls::ID.get
        entity = Entity.example
        version ||= Version.example
        time = ::Controls::Time.reference
        persisted_version ||= Version::Persistent.example

        persisted_time = time

        EntityCache::Record.new id, entity, version, time, persisted_version, persisted_time
      end
    end
  end
end

class EntityCache
  module Controls
    module Record
      def self.example(id=nil, version: nil, persistent_version: nil)
        id ||= ::Controls::ID.get
        entity = Entity.example
        version ||= Version.example
        time = ::Controls::Time.reference
        persistent_version ||= Version::Persistent.example

        persistent_time = time

        EntityCache::Record.new id, entity, version, time, persistent_version, persistent_time
      end
    end
  end
end

class EntityCache
  module Controls
    module Record
      def self.example(id=nil, version: nil, store_version: nil)
        id ||= ::Controls::ID.get
        entity = Entity.example
        version ||= Version.example
        time = ::Controls::Time.reference

        store_version ||= Version.example
        store_time = time

        EntityCache::Record.new id, entity, version, time, store_version, store_time
      end
    end
  end
end

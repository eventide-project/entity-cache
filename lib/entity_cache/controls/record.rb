class EntityCache
  module Controls
    module Record
      def self.example(id=nil, version: nil, persisted_version: nil)
        id ||= ID.example
        entity = Entity.example
        version ||= Version.example
        persisted_version ||= Version::Persistent.example

        time = Time.example
        persisted_time = time

        EntityCache::Record.new(
          id,
          entity,
          version,
          time,
          persisted_version,
          persisted_time
        )
      end

      module Persisted
        def self.example(id=nil)
          version = Version::Persistent.example

          Record.example(id, version: version)
        end
      end
    end
  end
end

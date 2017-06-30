class EntityCache
  class Record
    module LogText
      def self.get(record)
        "Entity: #{record&.entity.class}, Version: #{record&.version.inspect}, Time: #{record&.time.inspect}, Persisted Version: #{record&.persisted_version.inspect}, Persisted Time: #{record&.persisted_time.inspect}"
      end
    end
  end
end

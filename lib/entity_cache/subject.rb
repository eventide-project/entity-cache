class EntityCache
  class Subject
    include Schema::DataStructure

    attribute :entity_class, Class
    attribute :specifier, String

    def hash_key
      self.class.hash_key(entity_class, specifier)
    end
    alias_method :key, :hash_key
    alias_method :to_s, :hash_key

    def hash
      hash_key.hash
    end

    def self.hash_key(entity_class, specifier=nil)
      if specifier.nil?
        "#{entity_class}"
      else
        "#{entity_class}-#{specifier}"
      end
    end
  end
end

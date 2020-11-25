class EntityCache
  module Controls
    module Subject
      def self.example(entity_class: nil, specifier: nil, random: nil)
        entity_class ||= self.entity_class

        if specifier == :none
          specifier = nil
        else
          specifier = Specifier.example(specifier: specifier, random: random)
        end

        EntityCache::Subject.build({
          :entity_class => entity_class,
          :specifier => specifier
        })
      end

      def self.entity_class
        Entity::Example
      end

      def self.specifier
        Specifier.example
      end

      module Key
        def self.example(**args)
          subject = Subject.example(**args)
          subject.key
        end
      end
    end
  end
end

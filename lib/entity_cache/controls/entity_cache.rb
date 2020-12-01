class EntityCache
  module Controls
    module EntityCache
      def self.example(subject=nil, entity_class: nil, specifier: nil, random_specifier: nil)
        subject ||= Subject.example(entity_class: entity_class, specifier: specifier, random: random_specifier)

        ::EntityCache.new(subject)
      end
    end
  end
end

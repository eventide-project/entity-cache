class EntityCache
  module Controls
    module Store
      module External
        def self.example(subject=nil, entity_class: nil, specifier: nil, random: nil)
          random = true if random.nil?

          subject ||= Subject.example(random: random, entity_class: entity_class, specifier: specifier)

          Example.build(subject)
        end
      end
    end
  end
end

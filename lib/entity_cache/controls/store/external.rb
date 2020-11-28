class EntityCache
  module Controls
    module Store
      module External
        def self.example(subject=nil, entity_class: nil, specifier: nil)
          subject ||= Subject.example(random: true, entity_class: entity_class, specifier: specifier)

          Example.build(subject)
        end
      end
    end
  end
end

class EntityCache
  module Controls
    module Entity
      module NoTransformer
        def self.example
          some_attr = 'some-value'
          other_attr = 'other-value'

          Example.new(some_attr, other_attr)
        end

        Example = Struct.new(:some_attr, :other_attr)
      end
    end
  end
end

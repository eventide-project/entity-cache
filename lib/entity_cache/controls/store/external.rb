class EntityCache
  module Controls
    module Store
      module External
        def self.example(subject=nil)
          subject ||= Subject.example

          Example.build(subject)
        end
      end
    end
  end
end

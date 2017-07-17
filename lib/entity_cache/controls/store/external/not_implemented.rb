class EntityCache
  module Controls
    module Store
      module External
        module NotImplemented
          def self.example
            subject = Subject.example

            Example.new(subject)
          end

          class Example
            include EntityCache::Store::External
          end
        end
      end
    end
  end
end

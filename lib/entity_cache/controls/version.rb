class EntityCache
  module Controls
    module Version
      def self.example
        Current.example
      end

      module Current
        def self.example
          11
        end
      end

      module Previous
        def self.example
          Current.example - 1
        end
      end
    end
  end
end

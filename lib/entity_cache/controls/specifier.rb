class EntityCache
  module Controls
    module Specifier
      def self.example(specifier: nil, random: nil)
        specifier ||= 'SomeSpecifier'
        random ||= false

        if random
          specifier = "#{specifier}#{SecureRandom.hex(8)}"
        end

        specifier
      end
    end
  end
end

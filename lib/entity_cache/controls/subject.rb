class EntityCache
  module Controls
    module Subject
      def self.example(random: nil)
        random = true if random.nil?

        "TestSubject#{SecureRandom.hex(7) if random}"
      end
    end
  end
end

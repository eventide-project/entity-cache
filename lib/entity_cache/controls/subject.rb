class EntityCache
  module Controls
    module Subject
      def self.example
        "some-subject-#{SecureRandom.hex(7)}"
      end
    end
  end
end

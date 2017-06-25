class EntityCache
  module Controls
    module Time
      include Clock::Controls::Time

      def self.example(time=nil, precision: nil)
        precision ||= 5

        Clock::Controls::Time.example(
          time=nil,
          precision: precision
        )
      end
    end
  end
end

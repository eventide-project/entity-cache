class EntityCache
  module Controls
    Time = Clock::Controls::Time

    module Time
      def self.example(time=nil, precision: nil)
        time ||= Raw.example
        precision ||= 5
        ISO8601.example(time, precision: precision)
      end
    end
  end
end

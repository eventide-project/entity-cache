require_relative '../automated_init'

context "Record" do
  context "Age In Milliseconds" do
    time = Controls::Time::Offset::Raw.example(1)
    current_time = Controls::Time::Offset::Raw.example(11)

    record = Controls::Record.example(time: time)
    record.clock.now = current_time

    age = record.age_milliseconds

    test "Is difference between cache record time and current time" do
      assert(record.age_milliseconds == 10)
    end
  end
end

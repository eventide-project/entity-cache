require_relative '../automated_init'

context "Record" do
  context "Age In Milliseconds" do
    time = Time.now - 0.001

    record = Controls::Record.example(time: time)

    age = record.age_milliseconds

    test "Is difference between cache record time and current time" do
      comment 'This test is subject to timing'
      assert(age > 0)
    end
  end
end

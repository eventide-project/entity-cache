require_relative '../automated_init'

context "Record" do
  context "Persisted Age In Milliseconds" do
    time = Controls::Time::Offset::Raw.example(11)

    context "Record Is Persisted" do
      persisted_time = Controls::Time::Offset::Raw.example(1)

      record = Controls::Record.example(
        time: time,
        persisted_time: persisted_time
      )

      test "Is difference between time and persisted time" do
        assert(record.persisted_age_milliseconds == 10)
      end
    end

    context "Record Is Not Persisted" do
      record = Controls::Record.example(
        time: time,
        persisted: false
      )

      test "Is nil" do
        assert(record.persisted_age_milliseconds == nil)
      end
    end
  end
end

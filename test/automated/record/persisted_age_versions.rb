require_relative '../automated_init'

context "Record" do
  context "Persisted Age In Versions" do
    version = 11

    context "Record Is Persisted" do
      record = Controls::Record.example(
        version: version,
        persisted_version: 1
      )

      test "Is difference between version and persisted version" do
        assert(record.persisted_age_versions == 10)
      end
    end

    context "Record Is Not Persisted" do
      record = Controls::Record.example(
        version: version,
        persisted: false
      )

      test "Is nil" do
        assert(record.persisted_age_versions == nil)
      end
    end
  end
end

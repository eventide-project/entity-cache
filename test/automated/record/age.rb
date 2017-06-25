require_relative '../automated_init'

context "Cache Record" do
  context "Persistently stored version is set" do
    record = Controls::Record.example
    record.persisted_version = Controls::Version::Persistent.example

    test "Age is the difference between the current version and the persistently stored version" do
      control_version_difference = Controls::Version::SincePersisted.example

      assert record.versions_since_persisted == control_version_difference
    end
  end

  context "Persistently stored version is not set" do
    record = Controls::Record.example
    record.persisted_version = nil

    test "Age is one more than the current version" do
      control_version = record.version + 1

      assert record.versions_since_persisted == control_version
    end
  end
end

require_relative '../bench_init'

context "Cache Record" do
  context "Permanently stored version is set" do
    record = EntityCache::Controls::Record.example
    record.permanent_version = EntityCache::Controls::Version::Permanent.example

    test "Age is the difference between the current version and the permanently stored version" do
      control_age = EntityCache::Controls::Version::Age.example

      assert record.age == control_age
    end
  end

  context "Permanently stored version is not set" do
    record = EntityCache::Controls::Record.example
    record.permanent_version = nil

    test "Age is one more than the current version" do
      control_version = record.version + 1

      assert record.age == control_version
    end
  end
end

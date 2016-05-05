require_relative '../bench_init'

context "Cache Record" do
  version = EntityCache::Controls::Version.example
  permanent_version = 0
  record = EntityCache::Controls::Record.example permanent_version: permanent_version

  test "Age is the difference between the current version and the permanently stored version" do
    control_age = version - permanent_version

    assert record.age == control_age
  end
end

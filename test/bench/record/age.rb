require_relative '../bench_init'

context "Cache Record" do
  version = EntityCache::Controls::Version.example
  store_version = 0
  record = EntityCache::Controls::Record.example store_version: store_version

  test "Age is the difference between the current version and the stored version" do
    control_age = version - store_version

    assert record.age == control_age
  end
end

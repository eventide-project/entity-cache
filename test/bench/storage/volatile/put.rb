require_relative '../../bench_init'

context "Storing an entity in volatile storage" do
  id = Controls::ID.get
  entity = EntityCache::Controls::Entity.example
  version = EntityCache::Controls::Version
  reference_time = Controls::Time.reference

  volatile_storage = EntityCache::Controls::Storage::Volatile.example
  SubstAttr::Substitute.(:clock, volatile_storage)
  volatile_storage.clock.now = Time.parse reference_time

  record = volatile_storage.put id, entity, version

  test "Entity is stored" do
    assert record.entity == entity
  end

  test "Specified version is stored" do
    assert record.version == version
  end

  test "Current time is stored" do
    assert record.time == reference_time
  end
end

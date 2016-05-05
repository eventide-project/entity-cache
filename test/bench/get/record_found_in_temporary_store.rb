require_relative '../bench_init'

context "Record is found in temporary store" do
  id = Controls::ID.get
  record = EntityCache::Controls::Record.example id

  cache = EntityCache.new
  cache.temporary_store.put record

  test "Entity is returned" do
    entity = cache.get id

    assert entity == record.entity
  end

  test "Destructuring" do
    entity, version = cache.get id, include: :version

    assert entity == record.entity
    assert version == record.version
  end
end

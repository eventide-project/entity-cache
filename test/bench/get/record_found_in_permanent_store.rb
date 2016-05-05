require_relative '../bench_init'

context "Record is not found in temporary storage but is found in permanent storage" do
  id = Controls::ID.get
  record = EntityCache::Controls::Record.example id

  cache = EntityCache.new
  cache.permanent_store.add id, record.entity, record.version, record.time

  test "Entity is returned" do
    entity = cache.get id

    assert entity == record.entity
  end

  test "Destructuring" do
    entity, version = cache.get id, include: :version

    assert entity == record.entity
    assert version == record.version
  end

  test "Record is put into temporary storage" do
    cache.get id

    assert cache.temporary_store do
      put? record
    end
  end
end

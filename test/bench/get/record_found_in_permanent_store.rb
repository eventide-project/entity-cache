require_relative '../bench_init'

context "Record is not found in temporary storage but is found in permanent storage" do
  id = Controls::ID.get
  control_entity = EntityCache::Controls::Entity.example
  control_version = EntityCache::Controls::Version::Permanent.example
  time = Controls::Time.reference

  cache = EntityCache.new
  cache.permanent_store.add id, control_entity, control_version, time

  test "Entity is returned" do
    entity = cache.get id

    assert entity == control_entity
  end

  test "Destructuring" do
    entity, version = cache.get id, include: :version

    assert entity == control_entity
    assert version == control_version
  end

  test "Record is put into temporary storage" do
    control_record = EntityCache::Record.new id, control_entity, control_version, time, control_version, time

    cache.get id

    assert cache.temporary_store do
      put? control_record
    end
  end
end

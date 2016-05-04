require_relative '../../../bench_init'

context "Shared scoped volatile storage" do
  id = Controls::ID.get

  store = EntityCache::Storage::Volatile::Scope::Shared.build :some_subject

  entity = EntityCache::Controls::Entity.example
  store.put id, entity

  test "Entities stored in one cache are visible to other caches of the same subject" do
    other_store = EntityCache::Storage::Volatile::Scope::Shared.build :some_subject

    cached_record = other_store.get id

    assert cached_record.entity == entity
  end

  test "Entities stored in one cache are not visible to other caches of different subjects" do
    other_store = EntityCache::Storage::Volatile::Scope::Shared.build :other_subject

    cached_record = other_store.get id

    assert cached_record == nil
  end

  test "Different entities are stored separately according to their ID" do
    other_id = 'other-id'
    other_entity = EntityCache::Controls::Entity.example

    store.put other_id, other_entity

    assert store.get(id).entity == entity
    assert store.get(other_id).entity == other_entity
  end
end

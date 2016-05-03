require_relative '../../../bench_init'

context "Exclusive scoped volatile storage" do
  id = Controls::ID.get
  store = EntityCache::Storage::Volatile::Scope::Exclusive.build :some_subject

  entity = EntityCache::Controls::Entity.example
  store.put id, entity

  test "Entities stored in one cache are not shared with other caches" do
    other_store = EntityCache::Storage::Volatile::Scope::Exclusive.build :some_subject

    cached_entity = other_store.get id

    assert cached_entity == nil
  end

  test "Different entities are stored separately according to their ID" do
    other_id = 'other-id'
    other_entity = EntityCache::Controls::Entity.example

    store.put other_id, other_entity

    assert store.get(id) == entity
    assert store.get(other_id) == other_entity
  end
end

require_relative '../automated_init'

context "Put" do
  id = Controls::Record.id
  entity = Controls::Record.entity
  version = Controls::Record.version
  time = Controls::Record.time

  entity_cache = Controls::EntityCache.example
  entity_cache.clock.now = time

  entity_cache.put(id, entity, version)

  test "Record is put in internal store" do
    record = Controls::Record.example(persisted: false)

    internal_store = entity_cache.internal_store

    assert(internal_store.put?(record))
  end
end

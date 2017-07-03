require_relative '../automated_init'

context "Put" do
  id = Controls::Record.id
  entity = Controls::Record.entity
  version = Controls::Record.version
  time = Controls::Record.time

  entity_cache = EntityCache.new
  entity_cache.clock.now = time

  entity_cache.put(id, entity, version)

  test "Record is put in temporary store" do
    record = Controls::Record.example(persisted: false)

    temporary_store = entity_cache.temporary_store

    assert(temporary_store.put?(record))
  end
end

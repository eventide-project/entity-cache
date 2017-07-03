require_relative '../automated_init'

context "Put" do
  context "Previously Persisted" do
    id = Controls::Record.id
    entity = Controls::Record.entity
    version = Controls::Record.version
    time = Controls::Record.time
    persisted_version = Controls::Record.persisted_version
    persisted_time = Controls::Record.persisted_time

    entity_cache = EntityCache.new
    entity_cache.clock.now = time

    entity_cache.put(
      id,
      entity,
      version,
      persisted_version: persisted_version,
      persisted_time: persisted_time
    )

    test "Record is put in temporary store" do
      record = Controls::Record.example

      temporary_store = entity_cache.temporary_store

      assert(temporary_store.put?(record))
    end
  end
end

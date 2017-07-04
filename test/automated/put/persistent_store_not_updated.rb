require_relative '../automated_init'

context "Put" do
  context "Persistent Store Not Updated" do
    persist_interval = 11
    version = 21
    previous_persisted_version = 11
    previous_persisted_time = Controls::Record.time

    id = Controls::Record.id
    entity = Controls::Record.entity

    entity_cache = EntityCache.new
    entity_cache.clock.now = Controls::Record.persisted_time
    entity_cache.persist_interval = persist_interval

    entity_cache.put(
      id,
      entity,
      version,
      persisted_version: previous_persisted_version,
      persisted_time: previous_persisted_time
    )

    context "Persistent Store" do
      persistent_store = entity_cache.persistent_store

      test "Nothing is put" do
        refute(persistent_store.put?)
      end
    end

    context "Temporary Store" do
      temporary_store = entity_cache.temporary_store

      get_record = temporary_store.get(id)

      test "Persisted version is not changed" do
        assert(get_record.persisted_version == previous_persisted_version)
      end

      test "Persisted time is not changed" do
        assert(get_record.persisted_time == previous_persisted_time)
      end
    end
  end
end

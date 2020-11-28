require_relative '../automated_init'

context "Put" do
  context "External Store Not Updated" do
    persist_interval = Controls::PersistInterval.example
    version = (persist_interval * 2) - 1
    previous_persisted_version = persist_interval
    previous_persisted_time = Controls::Record.time

    id = Controls::Record.id
    entity = Controls::Record.entity

    entity_cache = Controls::EntityCache.example
    entity_cache.clock.now = Controls::Record.persisted_time
    entity_cache.persist_interval = persist_interval

    entity_cache.put(
      id,
      entity,
      version,
      persisted_version: previous_persisted_version,
      persisted_time: previous_persisted_time
    )

    context "External Store" do
      external_store = entity_cache.external_store

      test "Nothing is put" do
        refute(external_store.put?)
      end
    end

    context "Internal Store" do
      internal_store = entity_cache.internal_store

      get_record = internal_store.get(id)

      test "Persisted version is not changed" do
        assert(get_record.persisted_version == previous_persisted_version)
      end

      test "Persisted time is not changed" do
        assert(get_record.persisted_time == previous_persisted_time)
      end
    end
  end
end

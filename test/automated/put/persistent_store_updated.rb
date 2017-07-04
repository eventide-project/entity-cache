require_relative '../automated_init'

context "Put" do
  context "Persistent Store Updated" do
    persist_interval = 11
    version = 11
    time = Controls::Record.persisted_time

    id = Controls::Record.id
    entity = Controls::Record.entity

    entity_cache = EntityCache.new
    entity_cache.persist_interval = persist_interval
    entity_cache.clock.now = time

    entity_cache.put(id, entity, version)

    context "Persistent Store" do
      persistent_store = entity_cache.persistent_store

      context "Put" do
        put_record = persistent_store.telemetry_sink.one_record do |record|
          record.signal == :put
        end

        test "ID" do
          assert(put_record.data.id == id)
        end

        test "Entity" do
          assert(put_record.data.entity == entity)
        end

        test "Version" do
          assert(put_record.data.version == version)
        end

        test "Time" do
          assert(put_record.data.time == time)
        end
      end
    end

    context "Temporary Store" do
      temporary_store = entity_cache.temporary_store

      get_record = temporary_store.get(id)

      test "Persisted version is updated to current version" do
        assert(get_record.persisted_version == version)
      end

      test "Persisted time is updated to current time" do
        assert(get_record.persisted_time == time)
      end
    end
  end
end

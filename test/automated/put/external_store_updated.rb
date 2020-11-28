require_relative '../automated_init'

context "Put" do
  context "External Store Updated" do
    persist_interval = Controls::PersistInterval.example
    version = persist_interval
    time = Controls::Record.persisted_time

    id = Controls::Record.id
    entity = Controls::Record.entity

    entity_cache = Controls::EntityCache.example
    entity_cache.persist_interval = persist_interval
    entity_cache.clock.now = time

    entity_cache.put(id, entity, version)

    context "External Store" do
      external_store = entity_cache.external_store

      context "Put" do
        put_record = external_store.telemetry_sink.one_record do |record|
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

    context "Internal Store" do
      internal_store = entity_cache.internal_store

      get_record = internal_store.get(id)

      test "Persisted version is updated to current version" do
        assert(get_record.persisted_version == version)
      end

      test "Persisted time is updated to current time" do
        assert(get_record.persisted_time == time)
      end
    end
  end
end

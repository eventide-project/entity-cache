require_relative '../automated_init'

context "Get" do
  context "Restore From External Store" do
    id = Controls::ID.example
    entity = Controls::Entity.example
    persisted_version = Controls::Record.persisted_version
    persisted_time = Controls::Record.persisted_time

    entity_cache = Controls::EntityCache.example
    entity_cache.external_store.add(
      id,
      entity,
      persisted_version,
      persisted_time
    )

    record = entity_cache.get(id)

    context "Record" do
      test do
        assert(record.instance_of?(EntityCache::Record))
      end

      test "ID" do
        assert(record.id == id)
      end

      test "Entity" do
        assert(record.entity == entity)
      end

      test "Version" do
        assert(record.version == persisted_version)
      end

      test "Time" do
        assert(record.time == persisted_time)
      end

      test "Persisted version" do
        assert(record.persisted_version == persisted_version)
      end

      test "Persisted time" do
        assert(record.persisted_time == persisted_time)
      end
    end

    context "Internal Store" do
      internal_store = entity_cache.internal_store

      test "Record is added" do
        assert(internal_store.put?(record))
      end
    end
  end
end

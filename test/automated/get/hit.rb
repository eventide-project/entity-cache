require_relative '../automated_init'

context "Get" do
  context "Hit" do
    id = Controls::ID.example
    entity = Controls::Entity.example
    version = Controls::Record.version
    time = Controls::Record.time
    persisted_version = Controls::Record.persisted_version
    persisted_time = Controls::Record.persisted_time

    entity_cache = Controls::EntityCache.example
    entity_cache.internal_store.add(
      id,
      entity,
      version,
      time,
      persisted_version: persisted_version,
      persisted_time: persisted_time
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
        assert(record.version == version)
      end

      test "Time" do
        assert(record.time == time)
      end

      test "Persisted version" do
        assert(record.persisted_version == persisted_version)
      end

      test "Persisted time" do
        assert(record.persisted_time == persisted_time)
      end
    end
  end
end

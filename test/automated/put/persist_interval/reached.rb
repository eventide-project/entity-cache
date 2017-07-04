require_relative '../../automated_init'

context "Put" do
  context "Persist Interval" do
    context "Reached" do
      persist_interval = 11

      id = Controls::Record.id
      entity = Controls::Record.entity
      time = Controls::Record.time

      context "Previous Persisted Version Not Specified" do
        version = 11

        entity_cache = EntityCache.new
        entity_cache.persist_interval = persist_interval

        entity_cache.put(id, entity, version, time: time)

        test "Persistent store is updated" do
          assert(entity_cache.persistent_store.put?)
        end
      end

      context "Previous Persisted Version is Specified" do
        previous_persisted_version = 1
        version = 12

        entity_cache = EntityCache.new
        entity_cache.persist_interval = persist_interval

        entity_cache.put(
          id,
          entity,
          version,
          time: time,
          persisted_version: previous_persisted_version
        )

        test "Persistent store is updated" do
          assert(entity_cache.persistent_store.put?)
        end
      end
    end
  end
end

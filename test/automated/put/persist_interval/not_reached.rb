require_relative '../../automated_init'

context "Put" do
  context "Persist Interval" do
    context "Not Reached" do
      persist_interval = 11

      id = Controls::Record.id
      entity = Controls::Record.entity
      time = Controls::Record.time

      context "Previous Persisted Version Not Specified" do
        version = 9

        entity_cache = Controls::EntityCache.example
        entity_cache.persist_interval = persist_interval

        entity_cache.put(id, entity, version, time: time)

        test "External store is not updated" do
          refute(entity_cache.external_store.put?)
        end
      end

      context "Previous Persisted Version is Specified" do
        previous_persisted_version = 0
        version = 10

        entity_cache = Controls::EntityCache.example
        entity_cache.persist_interval = persist_interval

        entity_cache.put(
          id,
          entity,
          version,
          time: time,
          persisted_version: previous_persisted_version
        )

        test "External store is not updated" do
          refute(entity_cache.external_store.put?)
        end
      end
    end
  end
end

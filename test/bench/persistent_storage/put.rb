require_relative '../bench_init'

context "Storing an entity in persistent storage" do
  id = Controls::ID.get
  entity = EntityCache::Controls::Entity.example
  version = EntityCache::Controls::Version.example
  time = Controls::Time.reference

  storage = EntityCache::Controls::Storage::Persistent.example
  telemetry_sink = storage.class.register_telemetry_sink storage

  storage.put id, entity, version, time

  test "Entity is stored" do
    assert storage do
      stored? id, entity, version, time
    end
  end

  test "Telemetry is recorded" do
    control_id, control_entity = id, entity

    assert telemetry_sink do
      stored? do |id, entity|
        id == control_id && entity == control_entity
      end
    end
  end
end

require_relative '../automated_init'

context "Retrieving an entity from persistent storage" do
  id = EntityCache::Controls::ID.example
  control_entity = EntityCache::Controls::Entity.example
  control_version = EntityCache::Controls::Version.example
  control_time = EntityCache::Controls::Time.example

  storage = EntityCache::Controls::Storage::Persistent.example
  telemetry_sink = storage.class.register_telemetry_sink storage

  storage.put id, control_entity, control_version, control_time

  entity, version, time = storage.get id

  test "Entity is retrieved" do
    assert entity == control_entity
  end

  test "Version is retrieved" do
    assert version == control_version
  end

  test "Time is retrieved" do
    assert time == control_time
  end

  test "Telemetry is recorded" do
    control_id = id

    assert telemetry_sink do
      retrieved? do |id, entity|
        id == control_id && entity == control_entity
      end
    end
  end
end

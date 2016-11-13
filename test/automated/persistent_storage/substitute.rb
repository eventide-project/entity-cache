require_relative '../automated_init'

context "Persistent storage substitute" do
  id = EntityCache::Controls::ID.example
  entity = EntityCache::Controls::Entity.example
  version = EntityCache::Controls::Version.example
  time = EntityCache::Controls::Time.example

  context "Storing entities" do
    substitute = EntityCache::Controls::Storage::Persistent.substitute

    substitute.put id, entity, version, time

    test do
      control_id, control_entity, control_version = id, entity, version

      assert substitute do
        stored? do |id, entity, version|
          id == control_id && entity == control_entity && version == control_version
        end
      end
    end
  end

  context "Retrieving entities" do
    control_entity, control_version, control_time = entity, version, time

    substitute = EntityCache::Controls::Storage::Persistent.substitute

    substitute.add id, entity, version, time

    entity, version, time = substitute.get id

    test "Entity" do
      assert entity == control_entity
    end

    test "Version" do
      assert version == control_version
    end

    test "Time" do
      assert time == control_time
    end
  end
end
require_relative './bench_init'

context "Entity cache substitute" do
  id = Controls::ID
  control_entity = EntityCache::Controls::Entity.example
  control_version = EntityCache::Controls::Version.example
  control_persisted_version = EntityCache::Controls::Version::Persistent.example

  context "Get" do
    substitute = SubstAttr::Substitute.build EntityCache
    substitute.add id, control_entity, control_version

    test "Entity" do
      entity = substitute.get id

      assert entity == control_entity
    end

    test "Entity and version" do
      entity, version = substitute.get id, include: :version

      assert entity == control_entity
      assert version == control_version
    end
  end

  context "Put" do
    substitute = SubstAttr::Substitute.build EntityCache

    substitute.put id, control_entity, control_version, control_persisted_version, nil

    test "Cannot subsequently get record" do
      entity = substitute.get id

      assert entity == nil
    end

    test "Assertion" do
      control_id = id

      assert substitute do
        put? do |id, entity, version, persisted_version|
          id == control_id &&
            entity == control_entity &&
            version == control_version &&
            persisted_version == persisted_version
        end
      end
    end
  end
end

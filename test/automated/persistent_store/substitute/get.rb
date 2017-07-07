require_relative '../../automated_init'

context "Persistent Store" do
  context "Substitute" do
    context "Get" do
      id = Controls::ID.example

      context "Record Not Added" do
        substitute = SubstAttr::Substitute.build(EntityCache::Store::Persistent)

        entity, version, time = substitute.get(id)

        test "Entity is nil" do
          assert(entity.nil?)
        end

        test "Version is nil" do
          assert(version.nil?)
        end

        test "Time is nil" do
          assert(time.nil?)
        end
      end

      context "Record Added" do
        substitute = SubstAttr::Substitute.build(EntityCache::Store::Persistent)

        entity = Controls::Record.entity
        version = Controls::Record.persisted_version
        time = Controls::Record.persisted_time

        substitute.add(id, entity, version, time)

        entity, version, time = substitute.get(id)

        test "Entity is returned" do
          assert(entity == Controls::Record.entity)
        end

        test "Version is returned" do
          assert(version == Controls::Record.persisted_version)
        end

        test "Time is returned" do
          assert(time == Controls::Record.persisted_time)
        end
      end
    end
  end
end

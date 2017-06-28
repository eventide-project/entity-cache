require_relative '../../automated_init'

context "Persistent Store" do
  context "Substitute" do
    context "Put" do
      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.persisted_version
      time = Controls::Record.persisted_time

      substitute = SubstAttr::Substitute.build(EntityCache::Storage::Persistent)

      substitute.put(id, entity, version, time)

      context "Predicate" do
        test "ID" do
          assert(substitute.put? { |_id| _id == id })
        end

        test "Entity" do
          assert(substitute.put? { |_, _entity| _entity == entity })
        end

        test "Version" do
          assert(substitute.put? { |_, _, _version| _version == version })
        end

        test "Time" do
          assert(substitute.put? { |_, _, _, _time| _time == time })
        end
      end
    end
  end
end

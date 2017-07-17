require_relative '../../automated_init'

context "External Store" do
  context "Get" do
    context "Found (Cache Hit)" do
      id = Controls::ID.example

      subject = Controls::Store::External::Write.()

      external_store = Controls::Store::External.example(subject)

      entity, version, time = external_store.get(id)

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

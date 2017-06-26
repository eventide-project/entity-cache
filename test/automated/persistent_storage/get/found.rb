require_relative '../../automated_init'

context "Persistent Storage" do
  context "Get" do
    context "Found" do
      id = Controls::ID.example

      subject = Controls::Storage::Persistent::Write.()

      persistent_store = Controls::Storage::Persistent.example(subject)

      entity, version, time = persistent_store.get(id)

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

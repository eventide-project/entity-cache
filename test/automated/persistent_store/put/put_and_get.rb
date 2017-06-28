require_relative '../../automated_init'

context "Persistent Storage" do
  context "Put" do
    id = Controls::ID.example
    entity = Controls::Record.entity
    version = Controls::Record.persisted_version
    time = Controls::Record.persisted_time

    subject = Controls::Subject.example

    persistent_store = Controls::Storage::Persistent.example(subject)

    persistent_store.put(id, entity, version, time)

    context "Get Record Back" do
      get_entity, get_version, get_time = persistent_store.get(id)

      test "Entity is returned" do
        assert(get_entity == entity)
      end

      test "Version is returned" do
        assert(get_version == version)
      end

      test "Time is returned" do
        assert(get_time == time)
      end
    end
  end
end

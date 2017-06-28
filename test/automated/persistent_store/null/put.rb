require_relative '../../automated_init'

context "Persistent Store" do
  context "Substitute" do
    context "Put" do
      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.persisted_version
      time = Controls::Record.persisted_time

      subject = Controls::Subject.example

      persistent_store = EntityCache::Store::Persistent::Null.build(subject)

      test "No error is raised" do
        refute proc { persistent_store.put(id, entity, version, time) } do
          raises_error?
        end
      end
    end
  end
end

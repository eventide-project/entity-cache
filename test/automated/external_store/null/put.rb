require_relative '../../automated_init'

context "External Store" do
  context "Substitute" do
    context "Put" do
      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.persisted_version
      time = Controls::Record.persisted_time

      subject = Controls::Subject.example

      external_store = EntityCache::Store::External::Null.build(subject)

      test "No error is raised" do
        refute_raises do
          external_store.put(id, entity, version, time)
        end
      end
    end
  end
end

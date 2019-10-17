require_relative '../../automated_init'

context "External Store" do
  context "Put" do
    context "Not Implemented" do
      external_store = Controls::Store::External::NotImplemented.example

      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.version
      time = Controls::Record.time

      test "Error is raised" do
        assert_raises(Virtual::PureMethod::Error) do
          external_store.put(id, entity, version, time)
        end
      end
    end
  end
end

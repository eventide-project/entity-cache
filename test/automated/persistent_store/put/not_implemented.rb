require_relative '../../automated_init'

context "Persistent Storage" do
  context "Put" do
    context "Not Implemented" do
      persistent_store = Controls::Storage::Persistent::NotImplemented.example

      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.version
      time = Controls::Record.time

      test "Error is raised" do
        assert proc { persistent_store.put(id, entity, version, time) } do
          raises_error?(Virtual::PureMethodError)
        end
      end
    end
  end
end

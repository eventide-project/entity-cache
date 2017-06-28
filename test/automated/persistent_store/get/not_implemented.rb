require_relative '../../automated_init'

context "Persistent Storage" do
  context "Get" do
    context "Not Implemented" do
      persistent_store = Controls::Storage::Persistent::NotImplemented.example

      id = Controls::ID.example

      test "Error is raised" do
        assert proc { persistent_store.get(id) } do
          raises_error?(Virtual::PureMethodError)
        end
      end
    end
  end
end

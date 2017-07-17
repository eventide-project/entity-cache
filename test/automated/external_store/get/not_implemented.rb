require_relative '../../automated_init'

context "External Store" do
  context "Get" do
    context "Not Implemented" do
      external_store = Controls::Store::External::NotImplemented.example

      id = Controls::ID.example

      test "Error is raised" do
        assert proc { external_store.get(id) } do
          raises_error?(Virtual::PureMethodError)
        end
      end
    end
  end
end

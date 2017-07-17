require_relative '../../automated_init'

context "External Store" do
  context "Get" do
    context "Not Found (Cache Miss)" do
      id = Controls::ID.example

      external_store = Controls::Store::External.example

      entity, version, time = external_store.get(id)

      test "Entity is nil" do
        assert(entity.nil?)
      end

      test "Version is nil" do
        assert(version.nil?)
      end

      test "Time is nil" do
        assert(time.nil?)
      end
    end
  end
end

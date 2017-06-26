require_relative '../../automated_init'

context "Persistent Storage" do
  context "Get" do
    context "Not Found" do
      id = Controls::ID.example

      persistent_store = Controls::Storage::Persistent.example

      entity, version, time = persistent_store.get(id)

      test "Entity is nil" do
        assert(entity.nil?)
      end

      test "Version is nil" do
        assert(entity.nil?)
      end

      test "Time is nil" do
        assert(entity.nil?)
      end
    end
  end
end

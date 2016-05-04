require_relative '../../bench_init'

context "Retrieving an entity from volatile storage" do
  id = Controls::ID.get
  volatile_storage = EntityCache::Controls::Storage::Volatile.example

  context "Entity does not exist" do
    record = volatile_storage.get id

    test "Returns nothing" do
      assert record == nil
    end
  end

  context "Entity exists"
end

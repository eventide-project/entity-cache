require_relative '../../bench_init'

context "Retrieving an entity from volatile storage" do
  id = Controls::ID.get
  storage = EntityCache::Controls::Storage::Volatile.example

  context "Entity has not been stored previously" do
    record = storage.get id

    test "Returns nothing" do
      assert record == nil
    end
  end

  context "Entity has been stored previously" do
    control_record = EntityCache::Controls::Record.example
    storage.records[id] = control_record

    record = storage.get id

    test "Returns the record" do
      assert record == control_record
    end
  end
end

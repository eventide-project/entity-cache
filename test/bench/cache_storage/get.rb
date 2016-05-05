require_relative '../bench_init'

context "Retrieving an entity from volatile storage" do
  storage = EntityCache::Controls::Storage::Cache.example

  context "Entity has not been stored previously" do
    record = storage.get 'some-id'

    test "Returns nothing" do
      assert record == nil
    end
  end

  context "Entity has been stored previously" do
    control_record = EntityCache::Controls::Record.example
    storage.put control_record

    record = storage.get control_record.id

    test "Returns the record" do
      assert record == control_record
    end
  end
end

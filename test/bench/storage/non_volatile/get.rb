require_relative '../../bench_init'

context "Retrieving an entity from non-volatile storage" do
  id = Controls::ID.get
  storage = EntityCache::Controls::Storage::NonVolatile.example

  context "Entity has not been stored previously" do
    record = storage.get_record id

    test "Returns nothing" do
      assert record == nil
    end
  end

  context "Entity has been stored previously" do
    control_record = EntityCache::Controls::Record::NonVolatile.example
    storage.put control_record.id, control_record.entity, control_record.non_volatile_version

    record = storage.get_record id

    test "Returns the record" do
      assert record == control_record
    end
  end
end

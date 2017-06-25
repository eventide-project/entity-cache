require_relative '../automated_init'

context "Record is found in temporary store" do
  id = Controls::ID.example
  control_record = Controls::Record.example id

  cache = EntityCache.new
  cache.temporary_store.put control_record

  test "Record is returned" do
    record = cache.get id

    assert record == control_record
  end
end

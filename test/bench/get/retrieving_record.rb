require_relative '../bench_init'

context "Retrieving record directly" do
  id = Controls::ID.get
  control_record = EntityCache::Controls::Record.example id

  cache = EntityCache.new
  cache.temporary_store.put control_record

  test "Record is returned" do
    record = cache.get_record id

    assert record == control_record
  end
end

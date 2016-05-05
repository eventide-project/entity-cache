require_relative '../bench_init'

context "Storing cache record" do
  record = EntityCache::Controls::Record.example

  storage = EntityCache::Controls::Storage::Cache.example

  storage.put record

  test "Cache record is stored" do
    assert storage.records[record.id] == record
  end
end

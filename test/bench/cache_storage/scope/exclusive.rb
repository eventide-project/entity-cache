require_relative '../../bench_init'

context "Exclusive Scoped Cache Storage" do
  record = EntityCache::Controls::Record.example

  store = EntityCache::Storage::Cache::Scope::Exclusive.build :some_subject

  store.put record

  test "Entities stored in one cache are not shared with other caches" do
    other_store = EntityCache::Storage::Cache::Scope::Exclusive.build :some_subject

    cached_record = other_store.get record.id

    assert cached_record == nil
  end
end

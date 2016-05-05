require_relative '../../bench_init'

context "Shared scoped volatile storage" do
  record = EntityCache::Controls::Record.example

  store = EntityCache::Storage::Temporary::Scope::Shared.build :some_subject

  store.put record

  test "Entities stored in one cache are visible to other caches of the same subject" do
    other_store = EntityCache::Storage::Temporary::Scope::Shared.build :some_subject

    cached_record = other_store.get record.id

    assert cached_record == record
  end

  test "Entities stored in one cache are not visible to other caches of different subjects" do
    other_store = EntityCache::Storage::Temporary::Scope::Shared.build :other_subject

    cached_record = other_store.get record.id

    assert cached_record == nil
  end
end

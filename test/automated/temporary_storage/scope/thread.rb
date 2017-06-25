require_relative '../../automated_init'

context "Thread scoped temporary storage" do
  record = Controls::Record.example

  subject = Controls::Subject.example

  store = EntityCache::Storage::Temporary::Scope::Thread.build(subject)

  store.put(record)

  test "Entities stored in one cache are visible to other caches of the same subject" do
    other_store = EntityCache::Storage::Temporary::Scope::Thread.build(subject)

    cached_record = other_store.get(record.id)

    assert cached_record == record
  end

  test "Entities stored in one cache are not visible to other caches of different subjects" do
    other_subject = Controls::Subject.example(random: true)
    other_store = EntityCache::Storage::Temporary::Scope::Thread.build(other_subject)

    cached_record = other_store.get(record.id)

    assert cached_record == nil
  end
end

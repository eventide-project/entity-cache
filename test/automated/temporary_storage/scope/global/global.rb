require_relative '../../../automated_init'

context "Global scoped temporary storage" do
  entity = Controls::Entity::Transformer.example
  record = Controls::Record.example(entity: entity)

  subject = Controls::Subject.example

  store = EntityCache::Storage::Temporary::Scope::Global.build(subject)

  store.put(record)

  test "Entities stored in one cache are visible to other caches of the same subject" do
    other_store = EntityCache::Storage::Temporary::Scope::Global.build(subject)

    cached_record = other_store.get(record.id)

    assert cached_record == record
  end

  test "Entities stored in one cache are not visible to other caches of different subjects" do
    other_subject = Controls::Subject.example(random: true)
    other_store = EntityCache::Storage::Temporary::Scope::Global.build(other_subject)

    cached_record = other_store.get(record.id)

    assert cached_record == nil
  end

  test "Returned records contain copies of entity" do
    cached_record = store.get(record.id)

    refute cached_record.entity.equal?(record.entity)
    assert cached_record.entity == record.entity
  end
end

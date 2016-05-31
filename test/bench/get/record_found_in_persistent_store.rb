require_relative '../bench_init'

context "Record is not found in temporary storage but is found in persistent storage" do
  id = Controls::ID.get
  control_record = EntityCache::Controls::Record::Persisted.example id

  cache = EntityCache.new
  cache.persistent_store.add id, control_record.entity, control_record.version, control_record.time

  test "Record is returned" do
    record = cache.get id

    assert record == control_record
  end

  test "Record is put into temporary storage" do
    cache.get id

    assert cache.temporary_store do
      put? do |record|
        record == control_record
      end
    end
  end
end

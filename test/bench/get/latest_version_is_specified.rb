require_relative '../bench_init'

context "Latest version is specified when retrieving a cache record" do
  id = Controls::ID.get

  cache = EntityCache.new

  context "Entity is not cached" do
    record = cache.get id

    test "No record is returned" do
      assert record.nil?
    end
  end

  context "Cached entity version precedes specified latest version" do
    control_record = EntityCache::Controls::Record.example version: 0

    cache.temporary_store.put control_record

    record = cache.get id, latest_version: 1

    test "Record is returned" do
      assert record == control_record
    end
  end

  context "Cached entity version matches specified latest version" do
    control_record = EntityCache::Controls::Record.example version: 1

    cache.temporary_store.put control_record

    record = cache.get id, latest_version: 1

    test "Record is returned" do
      assert record == control_record
    end
  end

  context "Specified latest version precedes cached entity version" do
    control_record = EntityCache::Controls::Record.example version: 1

    cache.temporary_store.put control_record

    record = cache.get id, latest_version: 0

    test "No record is returned" do
      assert record.nil?
    end
  end
end

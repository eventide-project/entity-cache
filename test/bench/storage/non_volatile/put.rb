require_relative '../../bench_init'

context "Storing an entity in non volatile storage" do
  record = EntityCache::Controls::Record.example

  storage = EntityCache::Controls::Storage::NonVolatile.example
  storage.put_record record

  test "ID is stored" do
    control_id = Controls::ID.get

    assert storage do
      stored? do |id|
        id == control_id
      end
    end
  end

  test "Entity is stored" do
    assert storage do
      stored? do |_, entity|
        entity == record.entity
      end
    end
  end

  test "Specified version is stored" do
    assert storage do
      stored? do |_, _, version|
        version == record.version
      end
    end
  end

  test "Non volatile version of cache record is updated" do
    assert record.non_volatile_version == record.version
  end
end

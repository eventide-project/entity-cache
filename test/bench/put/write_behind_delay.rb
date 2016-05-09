require_relative '../bench_init'

context "Write behind delay for persistent storage" do
  id = Controls::ID.get
  record = EntityCache::Controls::Record.example id

  context "Delay is not specified" do
    cache = EntityCache.new nil

    cache.put_record record

    test "Persistent storage is not updated" do
      assert cache.persistent_store do
        stored_nothing?
      end
    end
  end

  context "Delay is not exceeded" do
    test do
      write_behind_delay = EntityCache::Controls::WriteBehindDelay::Within.example
      cache = EntityCache.new write_behind_delay

      cache.put_record record

      test "Persistent storage is not updated" do
        assert cache.persistent_store do
          stored_nothing?
        end
      end
    end
  end

  context "Delay is exceeded" do
    write_behind_delay = EntityCache::Controls::WriteBehindDelay::Exceeds.example
    cache = EntityCache.new write_behind_delay

    cache.put_record record

    test "Persistent storage is not updated" do
      assert cache.persistent_store do
        stored? do |id, entity, version|
          id == record.id && entity == record.entity && version == record.version
        end
      end
    end
  end
end

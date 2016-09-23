require_relative '../bench_init'

context "Write behind delay for persistent storage" do
  id = EntityCache::Controls::ID.example
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
    cache.clock.now = EntityCache::Controls::Time::Raw.example

    cache.put_record record

    test "Persistent storage is updated" do
      assert cache.persistent_store do
        stored? do |id, entity, version|
          id == record.id && entity == record.entity && version == record.version
        end
      end
    end

    test "Persistent version is updated in temporary record" do
      control_time = EntityCache::Controls::Time.example
      control_version = record.version

      assert cache.temporary_store do
        put? do |record|
          record.persisted_time == control_time &&
            record.persisted_version == control_version
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Version divergence limit for persistent storage" do
  id = Controls::ID.example
  record = Controls::Record.example id

  context "Delay is not specified" do
    cache = EntityCache.new

    cache.put_record record

    test "Persistent storage is not updated" do
      assert cache.persistent_store do
        stored_nothing?
      end
    end
  end

  context "Limit is not exceeded" do
    test do
      persist_interval = Controls::PersistInterval::Within.example
      cache = EntityCache.new
      cache.persist_interval = persist_interval

      cache.put_record record

      test "Persistent storage is not updated" do
        assert cache.persistent_store do
          stored_nothing?
        end
      end
    end
  end

  context "Limit is exceeded" do
    persist_interval = Controls::PersistInterval::Exceeds.example

    cache = EntityCache.new
    cache.persist_interval = persist_interval
    cache.clock.now = Controls::Time::Raw.example

    cache.put_record record

    test "Persistent storage is updated" do
      assert cache.persistent_store do
        stored? do |id, entity, version|
          id == record.id && entity == record.entity && version == record.version
        end
      end
    end

    test "Persistent version is updated in temporary record" do
      control_time = Controls::Time.example
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

require_relative '../bench_init'

context "Temporary cache storage" do
  control_time = Controls::Time::Raw.example

  record = EntityCache::Controls::Record.example
  cache = EntityCache.new
  cache.clock.now = control_time

  cache.put(
    record.id,
    record.entity,
    record.version,
    persisted_version: record.persisted_version,
    persisted_time: record.time
  )

  test "Writes to temporary storage" do
    assert cache.temporary_store do
      put? record
    end
  end

  test "Sets the time of the cache record to current time" do
    record = cache.get record.id

    assert record.time == Clock.iso8601(control_time)
  end
end

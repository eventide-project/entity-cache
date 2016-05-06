require_relative '../bench_init'

context "Temporary cache storage" do
  record = EntityCache::Controls::Record.example
  cache = EntityCache.new
  cache.clock.now = Controls::Time::Raw.example

  cache.put record.id, record.entity, record.version, record.persistent_version, record.time

  test "Writes to temporary storage" do
    assert cache.temporary_store do
      put? record
    end
  end

  test "Sets the time of the cache record to current time" do
    _, time = cache.get record.id, include: :time

    assert time == record.time
  end
end

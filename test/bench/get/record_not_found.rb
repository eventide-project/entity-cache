require_relative '../bench_init'

context "Record is found in neither temporary nor persistent storage" do
  id = Controls::ID.get

  cache = EntityCache.new

  test "No record is returned" do
    record = cache.get id

    assert record == nil
  end

  test "Nothing is written to temporary cache" do
    assert cache.temporary_store do
      empty?
    end
  end
end

require_relative '../bench_init'

context "Record is found in neither temporary nor permanent storage" do
  id = Controls::ID.get

  cache = EntityCache.new

  test "No entity is returned" do
    entity = cache.get id

    assert entity == nil
  end

  test "Nothing is written to temporary cache" do
    assert cache.temporary_store do
      empty?
    end
  end

  context "Destructuring" do
    test "Version indicates that no stream exists" do
      _, version = cache.get id, include: :version

      assert version == :no_stream
    end
  end
end

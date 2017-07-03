require_relative '../automated_init'

context "Get" do
  context "Miss" do
    id = Controls::ID.example

    entity_cache = EntityCache.new

    record = entity_cache.get(id)

    test "Returns nil" do
      assert(record.nil?)
    end
  end
end

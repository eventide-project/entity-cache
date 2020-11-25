require_relative '../automated_init'

context "Build" do
  context "Clock" do
    entity_class = Controls::Entity::Example

    entity_cache = EntityCache.build(entity_class)

    clock = entity_cache.clock

    test "Is configured" do
      assert(clock.instance_of?(Clock::UTC))
    end
  end
end

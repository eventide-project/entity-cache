require_relative '../automated_init'

context "Build" do
  context "Clock" do
    subject = Controls::Subject.example

    entity_cache = EntityCache.build(subject)

    clock = entity_cache.clock

    test "Is configured" do
      assert(clock.instance_of?(Clock::UTC))
    end
  end
end

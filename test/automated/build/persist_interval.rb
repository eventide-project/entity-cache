require_relative '../automated_init'

context "Build" do
  context "Persist Interval" do
    entity_class = Controls::Entity::Example

    context "Default" do
      entity_cache = EntityCache.build(entity_class)

      test "Infinite" do
        assert(entity_cache.persist_interval == Float::INFINITY)
      end
    end

    context "Specified" do
      persist_interval = Controls::PersistInterval.example

      entity_cache = EntityCache.build(entity_class, persist_interval: persist_interval)

      test do
        assert(entity_cache.persist_interval == persist_interval)
      end
    end
  end
end

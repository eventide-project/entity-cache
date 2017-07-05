require_relative '../automated_init'

context "Build" do
  context "Persist Interval" do
    context "Default" do
      subject = Controls::Subject.example

      entity_cache = EntityCache.build(subject)

      test "Infinite" do
        assert(entity_cache.persist_interval == Float::INFINITY)
      end
    end

    context "Specified" do
      subject = Controls::Subject.example

      entity_cache = EntityCache.build(subject, persist_interval: 11)

      test do
        assert(entity_cache.persist_interval == 11)
      end
    end
  end
end

require_relative '../automated_init'

context "Build" do
  context "External Store Implementation" do
    subject = Controls::Subject.example

    context "Not Specified" do
      entity_cache = EntityCache.build(subject)

      external_store = entity_cache.external_store

      test "Is null store" do
        null_store_class = EntityCache::Store::External::Null

        assert(external_store.instance_of?(null_store_class))
      end
    end

    context "Specified" do
      external_store_class = Controls::Store::External::Example

      context "Session Omitted" do
        entity_cache = EntityCache.build(
          subject,
          external_store: external_store_class
        )

        external_store = entity_cache.external_store

        test do
          assert(external_store.instance_of?(external_store_class))
        end
      end

      context "Session Specified" do
        session = Object.new

        entity_cache = EntityCache.build(
          subject,
          external_store: external_store_class,
          external_store_session: session
        )

        external_store = entity_cache.external_store

        test "Session is set" do
          assert(external_store.session == session)
        end
      end
    end
  end
end

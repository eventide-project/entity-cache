require_relative '../automated_init'

context "Build" do
  context "Persistent Store Implementation" do
    subject = Controls::Subject.example

    context "Not Specified" do
      entity_cache = EntityCache.build(subject)

      persistent_store = entity_cache.persistent_store

      test "Is null store" do
        null_store_class = EntityCache::Store::Persistent::Null

        assert(persistent_store.instance_of?(null_store_class))
      end
    end

    context "Specified" do
      persistent_store_class = Controls::Storage::Persistent::Example

      context "Session Omitted" do
        entity_cache = EntityCache.build(
          subject,
          persistent_store: persistent_store_class
        )

        persistent_store = entity_cache.persistent_store

        test do
          assert(persistent_store.instance_of?(persistent_store_class))
        end
      end

      context "Session Specified" do
        session = Object.new

        entity_cache = EntityCache.build(
          subject,
          persistent_store: persistent_store_class,
          persistent_store_session: session
        )

        persistent_store = entity_cache.persistent_store

        test "Session is set" do
          assert(persistent_store.session == session)
        end
      end
    end
  end
end

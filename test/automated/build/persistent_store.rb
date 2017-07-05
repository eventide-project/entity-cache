require_relative '../automated_init'

context "Build" do
  context "Persistent Store" do
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
      specified_persistent_store = Controls::Storage::Persistent.example

      context do
        entity_cache = EntityCache.build(
          subject,
          persistent_store: specified_persistent_store
        )

        persistent_store = entity_cache.persistent_store

        test do
          assert(persistent_store == specified_persistent_store)
        end
      end
    end
  end
end

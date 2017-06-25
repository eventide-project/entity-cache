require_relative './automated_init'

context "Build" do
  context "Persistent store and interval are not specified" do
    cache = EntityCache.build :some_subject

    test "Default is used" do
      assert cache.persistent_store.is_a?(EntityCache::Defaults.persistent_store)
    end
  end

  context "Persistent store and interval are both specified" do
    store_class = Controls::Storage::Persistent::Example
    cache = EntityCache.build :some_subject, persistent_store: store_class, persist_interval: 1

    test "Specified store is used" do
      assert(cache.persistent_store.is_a?(store_class))
    end

    test "Specified interval is used" do
      assert(cache.persist_interval == 1)
    end
  end

  context "Persistent store is specified but interval is not" do
    store_class = Controls::Storage::Persistent::Example

    test "Is an error" do
      assert proc { EntityCache.build :some_subject, persistent_store: store_class } do
        raises_error? EntityCache::Error
      end
    end
  end

  context "Persist interval is specified but store is not" do
    test "Is an error" do
      assert proc { EntityCache.build :some_subject, persist_interval: 1 } do
        raises_error? EntityCache::Error
      end
    end
  end
end

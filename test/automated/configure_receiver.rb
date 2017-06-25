require_relative './automated_init'

context "Configuring a receiver" do
  context "Persistent store is not specified" do
    receiver = OpenStruct.new
    cache = EntityCache.configure receiver, :some_subject

    test "Default is used" do
      assert cache.persistent_store.is_a?(EntityCache::Storage::Persistent::None)
    end
  end

  context "Persistent store is specified" do
    receiver = OpenStruct.new
    store_class = Controls::Storage::Persistent::Example
    cache = EntityCache.configure receiver, :some_subject, persistent_store: store_class, persist_interval: 1

    test "Specified store is used" do
      assert cache.persistent_store.is_a?(store_class)
    end
  end
end

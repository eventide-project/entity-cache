require_relative './bench_init'

context "Configuring a receiver" do
  context "Permanent store is not specified" do
    receiver = OpenStruct.new
    cache = EntityCache.configure receiver, :some_subject

    test "Default is used" do
      assert cache.permanent_store.is_a?(EntityCache::Storage::Permanent::None)
    end
  end

  context "Permanent store is specified" do
    receiver = OpenStruct.new
    cache = EntityCache.configure receiver, :some_subject, permanent_store: :control_example

    test "Specified store is used" do
      assert cache.permanent_store.is_a?(EntityCache::Controls::Storage::Permanent::Example)
    end
  end
end

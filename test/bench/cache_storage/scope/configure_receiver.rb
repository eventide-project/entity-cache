require_relative '../../bench_init'

context "Cache scope selection" do
  receiver = OpenStruct.new

  context "Default attribute name" do
    test do
      EntityCache::Storage::Cache.configure receiver, :some_subject

      assert receiver.cache_store.is_a?(EntityCache::Storage::Cache)
    end

    test "Subject is set" do
      assert receiver.cache_store.subject == :some_subject
    end
  end

  test "Attribute name is specified" do
    EntityCache::Storage::Cache.configure receiver, :some_subject, attr_name: :some_attr

    assert receiver.some_attr.is_a?(EntityCache::Storage::Cache)
  end

  test "Scope can be specified" do
    EntityCache::Storage::Cache.configure receiver, :some_subject, scope: :exclusive

    assert receiver.cache_store.is_a?(EntityCache::Storage::Cache::Scope::Exclusive)
  end
end

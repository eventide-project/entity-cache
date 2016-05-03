require_relative '../../../bench_init'

context "Cache scope selection" do
  receiver = OpenStruct.new

  context "Default attribute name" do
    test do
      EntityCache::Storage::Volatile.configure receiver, :some_subject

      assert receiver.volatile_storage.is_a?(EntityCache::Storage::Volatile)
    end

    test "Subject is set" do
      assert receiver.volatile_storage.subject == :some_subject
    end
  end

  test "Attribute name is specified" do
    EntityCache::Storage::Volatile.configure receiver, :some_subject, attr_name: :some_attr

    assert receiver.some_attr.is_a?(EntityCache::Storage::Volatile)
  end

  test "Scope can be specified" do
    EntityCache::Storage::Volatile.configure receiver, :some_subject, scope: :exclusive

    assert receiver.volatile_storage.is_a?(EntityCache::Storage::Volatile::Scope::Exclusive)
  end
end

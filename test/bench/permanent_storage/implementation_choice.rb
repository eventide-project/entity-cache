require_relative '../bench_init'

context "Select permanent choice implementation" do
  context "No name is specified" do
    store = EntityCache::Storage::Permanent.build :some_subject

    test "Inert implementation is chosen" do
      assert store.is_a?(EntityCache::Storage::Permanent::None)
    end
  end

  context "Implementation corresponding to name exists" do
    store = EntityCache::Storage::Permanent.build :some_subject, implementation: :control_example

    test "Implementation is used" do
      assert store.is_a?(EntityCache::Controls::Storage::Permanent::Example)
    end
  end

  context "No implementation corresponding to name exists" do
    test "Error is raised" do
      assert proc { EntityCache::Storage::Permanent.build :some_subject, implementation: :unknown } do
        raises_error? EntityCache::Storage::Permanent::Error
      end
    end
  end
end

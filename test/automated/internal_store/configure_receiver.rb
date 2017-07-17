require_relative '../automated_init'

context "Internal Store" do
  context "Configure Receiver" do
    receiver = OpenStruct.new

    subject = Controls::Subject.example

    context "Default Attribute Name" do
      test "Sets internal store attribute" do
        EntityCache::Store::Internal.configure(receiver, subject)

        assert(receiver.internal_store.is_a?(EntityCache::Store::Internal))
      end

      test "Subject is set on internal store" do
        assert(receiver.internal_store.subject == subject)
      end
    end

    context "Attribute Name is Specified" do
      EntityCache::Store::Internal.configure(receiver, subject, attr_name: :some_attr)

      test "Sets specified attribute name" do
        assert(receiver.some_attr.is_a?(EntityCache::Store::Internal))
      end
    end

    context "Scope is Specified" do
      EntityCache::Store::Internal.configure(receiver, subject, scope: :global)

      assert(receiver.internal_store.instance_of?(EntityCache::Store::Internal::Scope::Global))
    end
  end
end

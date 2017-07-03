require_relative '../automated_init'

context "Temporary Store" do
  context "Configure Receiver" do
    receiver = OpenStruct.new

    subject = Controls::Subject.example

    context "Default Attribute Name" do
      test "Sets temporary store attribute" do
        EntityCache::Store::Temporary.configure(receiver, subject)

        assert(receiver.temporary_store.is_a?(EntityCache::Store::Temporary))
      end

      test "Subject is set on temporary store" do
        assert(receiver.temporary_store.subject == subject)
      end
    end

    context "Attribute Name is Specified" do
      EntityCache::Store::Temporary.configure(receiver, subject, attr_name: :some_attr)

      test "Sets specified attribute name" do
        assert(receiver.some_attr.is_a?(EntityCache::Store::Temporary))
      end
    end

    context "Scope is Specified" do
      EntityCache::Store::Temporary.configure(receiver, subject, scope: :global)

      assert(receiver.temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Global))
    end
  end
end

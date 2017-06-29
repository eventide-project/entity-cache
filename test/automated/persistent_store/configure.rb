require_relative '../automated_init'

context "Persistent Store" do
  context "Configure" do
    receiver = OpenStruct.new

    subject = Controls::Subject.example

    Controls::Storage::Persistent::Example.configure(receiver, subject)

    test "Dependency is configured" do
      store = receiver.persistent_store

      assert(store.instance_of?(Controls::Storage::Persistent::Example))
    end
  end
end

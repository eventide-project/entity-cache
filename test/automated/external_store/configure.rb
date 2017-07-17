require_relative '../automated_init'

context "External Store" do
  context "Configure" do
    receiver = OpenStruct.new

    subject = Controls::Subject.example

    Controls::Store::External::Example.configure(receiver, subject)

    test "Dependency is configured" do
      store = receiver.external_store

      assert(store.instance_of?(Controls::Store::External::Example))
    end
  end
end

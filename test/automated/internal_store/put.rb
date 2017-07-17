require_relative '../automated_init'

context "Internal Store" do
  context "Put" do
    record = Controls::Record.example

    internal_store = Controls::Store::Internal.example

    internal_store.put(record)

    test "Record is stored" do
      id = record.id

      assert(internal_store.records[id] == record)
    end
  end
end

require_relative '../automated_init'

context "Temporary Store" do
  context "Put" do
    record = Controls::Record.example

    temporary_store = Controls::Storage::Temporary.example

    temporary_store.put(record)

    test "Record is stored" do
      id = record.id

      assert(temporary_store.records[id] == record)
    end
  end
end

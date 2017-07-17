require_relative '../automated_init'

context "Internal Store" do
  context "Get" do
    id = Controls::ID.example

    context "Record Not Stored" do
      internal_store = Controls::Store::Internal.example

      record = internal_store.get(id)

      test "Returns Nil" do
        assert(record.nil?)
      end
    end

    context "Record Stored" do
      stored_record = Controls::Record.example

      internal_store = Controls::Store::Internal.example
      internal_store.records[id] = stored_record

      record = internal_store.get(id)

      test "Returns Record" do
        assert(record == stored_record)
      end
    end
  end
end

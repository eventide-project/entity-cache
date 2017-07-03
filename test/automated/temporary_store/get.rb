require_relative '../automated_init'

context "Temporary Store" do
  context "Get" do
    id = Controls::ID.example

    context "Record Not Stored" do
      temporary_store = Controls::Storage::Temporary.example

      record = temporary_store.get(id)

      test "Returns Nil" do
        assert(record.nil?)
      end
    end

    context "Record Stored" do
      stored_record = Controls::Record.example

      temporary_store = Controls::Storage::Temporary.example
      temporary_store.records[id] = stored_record

      record = temporary_store.get(id)

      test "Returns Record" do
        assert(record == stored_record)
      end
    end
  end
end

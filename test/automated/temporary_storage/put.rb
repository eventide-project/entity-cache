require_relative '../automated_init'

context "Storing cache record" do
  record = Controls::Record.example

  storage = Controls::Storage::Temporary.example

  storage.put record

  test "Cache record is stored" do
    assert storage.records[record.id] == record
  end
end

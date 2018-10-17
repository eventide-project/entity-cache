require_relative '../automated_init'

context "Internal Store" do
  context "Count" do
    context "Record Is in the Store" do
      record = Controls::Record.example

      internal_store = Controls::Store::Internal.example

      assert(internal_store.empty?)
      internal_store.put(record)

      test "Count is the number of records in the cache" do
        assert(internal_store.count == 1)
      end
    end

    context "Record Is Not in the Store" do
      internal_store = Controls::Store::Internal.example

      assert(internal_store.empty?)

      count = internal_store.count

      test "Count is the number of records in the cache" do
        assert(internal_store.count == 0)
      end
    end
  end
end

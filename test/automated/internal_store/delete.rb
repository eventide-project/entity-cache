require_relative '../automated_init'

context "Internal Store" do
  context "Delete" do
    id = Controls::ID.example

    context "Record Is in the Store" do
      record = Controls::Record.example

      internal_store = Controls::Store::Internal.example

      assert(internal_store.empty?)
      internal_store.put(record)
      assert(internal_store.count == 1)

      record_count = internal_store.count

      deleted_record = internal_store.delete(id)

      test "Removes the cache record" do
        assert(internal_store.count == record_count - 1)
      end

      test "Returns cache record" do
        assert(deleted_record == record)
      end
    end

    context "Record Is Not in the Store" do
      internal_store = Controls::Store::Internal.example

      assert(internal_store.empty?)

      record_count = internal_store.count

      record = internal_store.delete(id)

      test "Doesn't remove a cache record" do
        assert(internal_store.count == record_count)
      end

      test "Returns nil" do
        assert(record.nil?)
      end
    end
  end
end

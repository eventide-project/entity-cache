require_relative '../automated_init'

context "Internal Store" do
  context "Empty" do
    context "Record Is in the Store" do
      record = Controls::Record.example

      internal_store = Controls::Store::Internal.example

      internal_store.put(record)

      test "Not empty" do
        refute(internal_store.empty?)
      end
    end

    context "Record Is Not in the Store" do
      internal_store = Controls::Store::Internal.example

      test "Is empty" do
        assert(internal_store.empty?)
      end
    end
  end
end

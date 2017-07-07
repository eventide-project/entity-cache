require_relative '../../automated_init'

context "Record" do
  context "Destructuring" do
    context "Nothing Included" do
      record = Controls::Record.example
      record.entity or fail

      return_value = EntityCache::Record.destructure(record)

      test "Entity is returned" do
        assert(return_value == record.entity)
      end
    end
  end
end

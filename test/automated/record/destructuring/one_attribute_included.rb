require_relative '../../automated_init'

context "Record" do
  context "Destructuring" do
    context "One Attribute Included" do
      record = Controls::Record.example
      record.entity or fail
      record.version or fail

      return_value = EntityCache::Record.destructure(record, :version)

      test "Entity and specified attribute are returned" do
        assert(return_value == [record.entity, record.version])
      end
    end
  end
end

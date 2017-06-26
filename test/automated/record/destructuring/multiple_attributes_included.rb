require_relative '../../automated_init'

context "Record" do
  context "Destructuring" do
    context "Multiple Attributes Included" do
      record = Controls::Record.example
      record.entity or fail
      record.version or fail
      record.time or fail

      return_value = EntityCache::Record.destructure(record, [:version, :time])

      test "Entity and all specified attributes are returned" do
        control_return_value = [record.entity, record.version, record.time]

        assert(return_value == control_return_value)
      end
    end
  end
end

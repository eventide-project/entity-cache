require_relative '../bench_init'

context "Destructuring Cache Records" do
  record = EntityCache::Controls::Record.example

  context "No attributes are specified" do
    test "Entity is returned by itself" do
      entity = record.destructure

      assert entity == record.entity
    end
  end

  context "Attributes are specified" do
    test "ID" do
      assert record.destructure(:id) == [record.entity, record.id]
    end

    test "Time" do
      assert record.destructure(:time) == [record.entity, record.time]
    end

    test "Store version" do
      assert record.destructure(:permanent_version) == [record.entity, record.permanent_version]
    end

    test "Store time" do
      assert record.destructure(:permanent_time) == [record.entity, record.permanent_time]
    end

    test "Multiple attributes" do
      entity, id, time = record.destructure [:id, :time]

      assert entity == record.entity
      assert id == record.id
      assert time == record.time
    end

    context "Version" do
      context "Value is not set" do
        record.version = nil

        test "No stream is indicated" do
          assert record.destructure(:version) == [record.entity, :no_stream]
        end
      end

      context "Value is set" do
        record.version = version

        test "Version number is returned" do
          assert record.destructure(:version) == [record.entity, record.version]
        end
      end
    end
  end
end

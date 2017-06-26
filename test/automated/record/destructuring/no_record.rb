require_relative '../../automated_init'

context "Record" do
  context "Destructuring" do
    context "No Record" do
      record = nil

      context "Version" do
        _, version = EntityCache::Record.destructure(record, :version)

        no_stream_name = MessageStore::NoStream.name

        test "Is #{no_stream_name}" do
          assert(version == no_stream_name)
        end
      end

      context "ID" do
        _, id = EntityCache::Record.destructure(record, :id)

        test "Is nil" do
          assert(id.nil?)
        end
      end

      context "Entity" do
        entity = EntityCache::Record.destructure(record)

        test "Is nil" do
          assert(entity.nil?)
        end
      end

      context "Time" do
        _, time = EntityCache::Record.destructure(record, :time)

        test "Is nil" do
          assert(time == nil)
        end
      end

      context "Persisted Time" do
        _, persisted_time = EntityCache::Record.destructure(record, :persisted_time)

        test "Is nil" do
          assert(persisted_time == nil)
        end
      end

      context "Persisted Version" do
        _, persisted_version = EntityCache::Record.destructure(record, :persisted_version)

        test "Is nil" do
          assert(persisted_version == nil)
        end
      end
    end
  end
end

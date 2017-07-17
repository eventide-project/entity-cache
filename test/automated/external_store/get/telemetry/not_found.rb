require_relative '../../../automated_init'

context "External Store" do
  context "Get" do
    context "Telemetry" do
      context "Not Found (Cache Miss)" do
        id = Controls::ID.example

        external_store = Controls::Store::External.example

        telemetry_sink = Controls::Store::External::Example.register_telemetry_sink(external_store)

        external_store.get(id)

        fail if telemetry_sink.records.count > 1

        telemetry_record, * = telemetry_sink.get_records

        test "ID is recorded" do
          entity = telemetry_record.data.id

          assert(entity == id)
        end

        test "Entity is nil" do
          entity = telemetry_record.data.entity

          assert(entity.nil?)
        end

        test "Version is nil" do
          version = telemetry_record.data.version

          assert(version.nil?)
        end

        test "Time is nil" do
          time = telemetry_record.data.time

          assert(time.nil?)
        end
      end
    end
  end
end

require_relative '../../../automated_init'

context "External Store" do
  context "Get" do
    context "Telemetry" do
      context "Found (Cache Hit)" do
        id = Controls::ID.example

        subject = Controls::Store::External::Write.()

        external_store = Controls::Store::External.example(subject)

        telemetry_sink = Controls::Store::External::Example.register_telemetry_sink(external_store)

        external_store.get(id)

        fail if telemetry_sink.records.count > 1

        telemetry_record, * = telemetry_sink.get_records

        test "ID is recorded" do
          entity = telemetry_record.data.id

          assert(entity == id)
        end

        test "Entity is recorded" do
          entity = telemetry_record.data.entity

          assert(entity == Controls::Record.entity)
        end

        test "Version is recorded" do
          version = telemetry_record.data.version

          assert(version == Controls::Record.persisted_version)
        end

        test "Time is recorded" do
          time = telemetry_record.data.time

          assert(time == Controls::Record.persisted_time)
        end
      end
    end
  end
end

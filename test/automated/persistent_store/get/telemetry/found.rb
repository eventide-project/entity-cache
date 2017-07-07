require_relative '../../../automated_init'

context "Persistent Storage" do
  context "Get" do
    context "Telemetry" do
      context "Found (Cache Hit)" do
        id = Controls::ID.example

        subject = Controls::Storage::Persistent::Write.()

        persistent_store = Controls::Storage::Persistent.example(subject)

        telemetry_sink = Controls::Storage::Persistent::Example.register_telemetry_sink(persistent_store)

        persistent_store.get(id)

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

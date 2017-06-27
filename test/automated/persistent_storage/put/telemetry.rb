require_relative '../../automated_init'

context "Persistent Storage" do
  context "Put" do
    context "Telemetry" do
      persistent_store = Controls::Storage::Persistent.example

      telemetry_sink = Controls::Storage::Persistent::Example.register_telemetry_sink(persistent_store)

      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.version
      time = Controls::Record.time

      persistent_store.put(id, entity, version, time)

      fail if telemetry_sink.records.count > 1

      telemetry_record, * = telemetry_sink.put_records

      test "Is recorded" do
        refute(telemetry_record.nil?)
      end

      test "ID" do
        assert(telemetry_record.data.id == id)
      end

      test "Entity" do
        assert(telemetry_record.data.entity == entity)
      end

      test "Version" do
        assert(telemetry_record.data.version == version)
      end

      test "Time" do
        assert(telemetry_record.data.time == time)
      end
    end
  end
end

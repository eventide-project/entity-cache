require_relative '../../automated_init'

context "External Store" do
  context "Put" do
    context "Telemetry" do
      external_store = Controls::Store::External.example

      telemetry_sink = Controls::Store::External::Example.register_telemetry_sink(external_store)

      id = Controls::ID.example
      entity = Controls::Record.entity
      version = Controls::Record.version
      time = Controls::Record.time

      external_store.put(id, entity, version, time)

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

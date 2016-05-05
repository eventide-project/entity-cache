class EntityCache
  dependency :logger, Telemetry::Logger
  dependency :permanent_store, Storage::Permanent
  dependency :temporary_store, Storage::Temporary

  def self.build(permanent_store: nil)
    instance = new
    Telemetry::Logger.configure instance
    Storage::Temporary.configure instance

    permanent_store.configure instance if permanent_store

    instance
  end
end

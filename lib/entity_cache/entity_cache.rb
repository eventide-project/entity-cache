class EntityCache
  attr_writer :persist_interval
  def persist_interval
    @persist_interval ||= Defaults.persist_interval
  end

  dependency :clock, Clock::UTC
  dependency :temporary_store, Store::Temporary
  dependency :persistent_store, Store::Persistent

  def get(id)
    record = temporary_store.get(id)

    if record.nil?
      record = restore(id)
    end

    record
  end

  def put(id, entity, version, time: nil, persisted_version: nil, persisted_time: nil)
    time ||= clock.now

    if (version - persisted_version.to_i) >= persist_interval
      persistent_store.put(id, entity, version, time)

      persisted_version = version
      persisted_time = time
    end

    record = Record.build(
      id,
      entity,
      version,
      time,
      persisted_version: persisted_version,
      persisted_time: persisted_time
    )

    temporary_store.put(record)

    record
  end

  def restore(id)
    entity, version, time = persistent_store.get(id)

    return nil if entity.nil?

    record = Record.build(
      id,
      entity,
      version,
      time,
      persisted_version: version,
      persisted_time: time
    )

    temporary_store.put(record)

    record
  end
end

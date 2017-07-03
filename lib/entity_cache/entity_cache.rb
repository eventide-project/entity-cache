class EntityCache
  dependency :temporary_store, Store::Temporary
  dependency :persistent_store, Store::Persistent

  def get(id)
    record = temporary_store.get(id)

    if record.nil?
      record = restore(id)
    end

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

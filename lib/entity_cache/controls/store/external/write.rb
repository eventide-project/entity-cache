class EntityCache
  module Controls
    module Store
      module External
        module Write
          def self.call
            subject = Subject.example

            entity = Controls::Entity.example
            entity_data = Transform::Write.raw_data(entity)

            persisted_time_iso8601 = Controls::Record.persisted_time.iso8601(5)

            data = [
              entity_data,
              Controls::Record.persisted_version,
              persisted_time_iso8601
            ]

            text = JSON.generate(data)

            path = External.path(subject)

            File.write(path, text)

            return subject
          end
        end
      end
    end
  end
end

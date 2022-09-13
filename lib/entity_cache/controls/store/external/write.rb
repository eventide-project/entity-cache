class EntityCache
  module Controls
    module Store
      module External
        module Write
          def self.call
            subject = Subject.example

            entity_data = Controls::Entity.example.to_h

            persisted_time_iso8601 = Controls::Record.persisted_time.iso8601(5)

            text = YAML.dump([
              entity_data,
              Controls::Record.persisted_version,
              persisted_time_iso8601
            ])

            path = External.path(subject)

            File.write(path, text)

            return subject
          end
        end
      end
    end
  end
end

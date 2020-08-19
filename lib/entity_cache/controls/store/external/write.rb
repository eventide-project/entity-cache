class EntityCache
  module Controls
    module Store
      module External
        module Write
          def self.call
            subject = Subject.example

            persisted_time = Controls::Record.persisted_time

            persisted_time_iso8601 = Clock.iso8601(persisted_time)

            text = YAML.dump([
              Controls::Entity.example,
              Controls::Record.persisted_version,
              persisted_time_iso8601
            ])

            path = External.path(subject)

            File.open(path, 'w') do |io|
              io.write(text)
            end

            return subject
          end
        end
      end
    end
  end
end

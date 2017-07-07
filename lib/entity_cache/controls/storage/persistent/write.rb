class EntityCache
  module Controls
    module Storage
      module Persistent
        module Write
          def self.call
            subject = Subject.example

            text = YAML.dump([
              Controls::Entity.example,
              Controls::Record.persisted_version,
              Controls::Record.persisted_time
            ])

            path = Persistent.path(subject)

            File.write(path, text)

            return subject
          end
        end
      end
    end
  end
end

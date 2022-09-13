class EntityCache
  module Controls
    module Store
      module External
        class Example
          include EntityCache::Store::External

          attr_accessor :session

          def configure(session: nil)
            self.session = session
          end

          def get(id)
            path = path(id)

            return unless File.size?(path)

            text = File.read(path)

            entity_data, version, time_iso8601 = JSON.parse(text, symbolize_names: true)

            entity = Entity::Example.new(*entity_data)

            time = Clock.parse(time_iso8601)

            return entity, version, time
          end

          def put(id, entity, version, time)
            path = path(id)

            entity_data = Transform::Write.raw_data(entity)

            time_iso8601 = Clock.iso8601(time)

            data = [
              entity_data,
              version,
              time_iso8601
            ]

            text = JSON.generate(data)

            File.write(path, text)
          end

          def path(id)
            External.path(subject, id)
          end
        end

        def self.path(subject, id=nil)
          id ||= ID.example

          filename = "#{subject.to_s.gsub('/', '-')}-#{id}.yaml"

          full_name = File.join(tmpdir, filename)

          full_name
        end

        def self.tmpdir
          @tmpdir ||= Dir.tmpdir
        end
      end
    end
  end
end

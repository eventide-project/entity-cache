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

            entity, version, time = YAML.load(text)

            return entity, version, time
          end

          def put(id, entity, version, time)
            path = path(id)

            text = YAML.dump([entity, version, time])

            File.open(path, 'w') do |io|
              io.write(text)
            end
          end

          def path(id)
            External.path(subject, id)
          end
        end

        def self.path(subject, id=nil)
          id ||= ID.example

          File.join(tmpdir, "#{subject}-#{id}.yaml")
        end

        def self.tmpdir
          @tmpdir ||= Dir.tmpdir
        end
      end
    end
  end
end

class EntityCache
  module Controls
    module Store
      module External
        def self.example(subject=nil)
          subject ||= Subject.example

          Example.build(subject)
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

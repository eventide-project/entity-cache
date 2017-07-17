class EntityCache
  module Store
    class Internal
      module Substitute
        def self.build
          Internal.new
        end

        class Internal < Scope::Exclusive
          def add(id, entity, version, time, persisted_version: nil, persisted_time: nil)
            record = Record.build(
              id,
              entity,
              version,
              time,
              persisted_version: persisted_version,
              persisted_time: persisted_time
            )

            put(record)
          end

          def put?(record=nil)
            if record.nil?
              records.any?
            else
              records.any? do |_, r|
                r == record
              end
            end
          end
        end
      end
    end
  end
end

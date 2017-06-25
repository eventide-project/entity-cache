class EntityCache
  module Storage
    class Temporary
      module Scope
        class Global < Temporary
          def records
            subject_registry[subject] ||= Store.new
          end

          def subject_registry
            @@subject_registry ||= {}
          end

          class Store
            def [](id)
              record = table[id]

              return nil if record.nil?

              raw_entity = Transform::Write.raw_data(record.entity)
              new_entity = Transform::Read.instance(raw_entity, record.entity.class)

              record = record.dup
              record.entity = new_entity
              record
            end

            def []=(id, record)
              Transform.transformer(record.entity)

              table[id] = record
            end

            def table
              @table ||= {}
            end
          end
        end
      end
    end
  end
end

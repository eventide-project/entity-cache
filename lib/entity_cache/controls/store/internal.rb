class EntityCache
  module Controls
    module Store
      module Internal
        def self.example
          Example.new
        end

        class Example < EntityCache::Store::Internal
          def records
            @records ||= {}
          end

          def put?(id, record=nil)
            if record.nil?
              records.key?(id)
            else
              records[id] == record
            end
          end
        end
      end
    end
  end
end

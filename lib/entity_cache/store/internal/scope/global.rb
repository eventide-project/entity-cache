class EntityCache
  module Store
    class Internal
      module Scope
        class Global < Internal
          def records
            records_by_subject[subject]
          end

          def records_by_subject
            mutex.synchronize do
              @@records_by_subject ||= {}
              @@records_by_subject[subject] ||= ThreadSafeHash.new
              @@records_by_subject
            end
          end

          mutex = ::Thread::Mutex.new
          define_method(:mutex) do
            mutex
          end

          class ThreadSafeHash < ::Hash
            def [](key)
              value = super(key)
              value = Transform::Copy.(value) unless value.nil?
              value
            end
          end
        end
      end
    end
  end
end

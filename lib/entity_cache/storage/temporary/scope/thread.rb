class EntityCache
  module Storage
    class Temporary
      module Scope
        class Thread < Temporary
          def records
            subject_registry[subject] ||= {}
          end

          def subject_registry
            current_thread = ::Thread.current

            if current_thread.thread_variable?(thread_local_variable)
              subject_registry = current_thread.thread_variable_get(thread_local_variable)
            else
              subject_registry = {}

              current_thread.thread_variable_set(thread_local_variable, subject_registry)
            end

            subject_registry
          end

          def thread_local_variable
            :entity_cache_subject_registry
          end
        end
      end
    end
  end
end

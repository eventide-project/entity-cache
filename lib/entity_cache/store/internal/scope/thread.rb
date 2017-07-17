class EntityCache
  module Store
    class Internal
      module Scope
        class Thread < Internal
          def records
            records_by_subject[subject]
          end

          def records_by_subject
            current_thread = ::Thread.current

            records_by_subject = current_thread.thread_variable_get(thread_variable)

            if records_by_subject.nil?
              records_by_subject = Hash.new do |hash, subject|
                hash[subject] = {}
              end

              current_thread.thread_variable_set(thread_variable, records_by_subject)
            end

            records_by_subject
          end

          thread_variable = :"entity_cache_records_by_subject_#{SecureRandom.hex(7)}"

          define_method(:thread_variable) do
            thread_variable
          end
        end
      end
    end
  end
end

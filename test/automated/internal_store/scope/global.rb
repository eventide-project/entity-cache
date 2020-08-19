require_relative '../../automated_init'

context "Internal Store" do
  context "Global Scope" do
    subject = Controls::Subject.example

    put_record = Controls::Record.example

    store = EntityCache::Store::Internal::Scope::Global.build(subject)

    store.put(put_record)

    context "Get Record Back From Store" do
      record = store.get(put_record.id)

      test "Returns copy of record" do
        assert(Transform::Copy.copied?(record, put_record))
      end

      test "Entity is copied" do
        assert(Transform::Copy.copied?(record.entity, put_record.entity))
      end
    end

    context "Get Record From Other Store" do
      context "Subjects Match" do
        other_store = EntityCache::Store::Internal::Scope::Global.build(subject)

        record = other_store.get(put_record.id)

        test "Returns copy of record" do
          assert(Transform::Copy.copied?(record, put_record))
        end

        test "Entity is copied" do
          assert(Transform::Copy.copied?(record.entity, put_record.entity))
        end
      end

      context "Subjects Do Not Match" do
        other_subject = Controls::Subject.example

        other_store = EntityCache::Store::Internal::Scope::Global.build(other_subject)

        record = other_store.get(put_record.id)

        test "Returns nil" do
          assert(record.nil?)
        end
      end

      if RUBY_ENGINE == 'mruby'
        _context "Within Another Thread (Cannot Be Tested Under MRuby)"
      else
        context "Within Another Thread" do
          record = nil

          thread = Thread.new do
            other_store = EntityCache::Store::Internal::Scope::Global.build(subject)

            record = other_store.get(put_record.id)
          end
          thread.join

          test "Returns copy of record" do
            assert(Transform::Copy.copied?(record, put_record))
          end

          test "Entity is copied" do
            assert(Transform::Copy.copied?(record.entity, put_record.entity))
          end
        end
      end
    end
  end
end

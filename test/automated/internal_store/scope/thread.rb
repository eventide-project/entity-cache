require_relative '../../automated_init'

context "Internal Store" do
  context "Thread Scope" do
    subject = Controls::Subject.example

    put_record = Controls::Record.example

    store = EntityCache::Store::Internal::Scope::Thread.build(subject)

    store.put(put_record)

    context "Get Record Back From Store" do
      record = store.get(put_record.id)

      test "Returns record" do
        assert(record == put_record)
      end

      test "Entity is not copied" do
        refute(Transform::Copy.copied?(record, put_record))
      end
    end

    context "Get Record From Other Store" do
      context "Subjects Match" do
        other_store = EntityCache::Store::Internal::Scope::Thread.build(subject)

        record = other_store.get(put_record.id)

        test "Returns record" do
          assert(record == put_record)
        end

        test "Entity is not copied" do
          refute(Transform::Copy.copied?(record, put_record))
        end
      end

      context "Subjects Do Not Match" do
        other_subject = Controls::Subject.example

        other_store = EntityCache::Store::Internal::Scope::Thread.build(other_subject)

        record = other_store.get(put_record.id)

        test "Returns nil" do
          assert(record.nil?)
        end
      end

      context "Within Another Thread" do
        record = nil

        thread = Thread.new do
          other_store = EntityCache::Store::Internal::Scope::Global.build(subject)

          record = other_store.get(put_record.id)
        end
        thread.join

        test "Returns nil" do
          assert(record == nil)
        end
      end
    end
  end
end

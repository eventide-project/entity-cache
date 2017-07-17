require_relative '../../automated_init'

context "Internal Store" do
  context "Exclusive Scope" do
    put_record = Controls::Record.example

    store = EntityCache::Store::Internal::Scope::Exclusive.new

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
      other_store = EntityCache::Store::Internal::Scope::Exclusive.new

      record = other_store.get(put_record.id)

      test "Returns nil" do
        assert(record.nil?)
      end
    end
  end
end

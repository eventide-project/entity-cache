require_relative './automated_init'

context "Entity cache substitute" do
  id = EntityCache::Controls::ID.example
  control_record = EntityCache::Controls::Record.example id

  context "Get" do
    substitute = SubstAttr::Substitute.build EntityCache
    substitute.clock.now = Time.parse control_record.time
    substitute.add id, control_record.entity, control_record.version, persisted_version: control_record.persisted_version

    test "Record is returned" do
      record = substitute.get id

      assert record == control_record
    end
  end

  context "Put" do
    substitute = SubstAttr::Substitute.build EntityCache

    context "No record has been put in the cache substitute" do
      test "Assertion" do
        refute substitute do
          put?
        end
      end
    end

    context "After a record has been put in the cache substitute" do
      substitute.put_record control_record

      test "Cannot subsequently get record" do
        record = substitute.get id

        assert record == nil
      end

      test "Assertion" do
        control_id = id

        assert substitute do
          put? do |record|
            record == control_record
          end
        end
      end
    end
  end
end

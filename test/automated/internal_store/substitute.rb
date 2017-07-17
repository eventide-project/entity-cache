require_relative '../automated_init'

context "Internal Store" do
  context "Substitute" do
    id = Controls::ID.example

    context "Get" do
      substitute = SubstAttr::Substitute.build(EntityCache::Store::Internal)

      context "Record Not Added" do
        record = substitute.get(id)

        test "Returns nil" do
          assert(record.nil?)
        end
      end

      context "Record Added" do
        entity = Controls::Record.entity
        version = Controls::Record.version
        time = Controls::Record.time
        persisted_version = Controls::Record.persisted_version
        persisted_time = Controls::Record.persisted_time

        substitute.add(
          id,
          entity,
          version,
          time,
          persisted_version: persisted_version,
          persisted_time: persisted_time
        )

        record = substitute.get(id)

        test "Returns record" do
          control_record = Controls::Record.example

          assert(record == control_record)
        end
      end
    end

    context "Put" do
      put_record = Controls::Record.example

      substitute = SubstAttr::Substitute.build(EntityCache::Store::Internal)

      substitute.put(put_record)

      test "Get" do
        get_record = substitute.get(id)

        assert(get_record == put_record)
      end
    end

    context "Put Predicate" do
      context "Nothing Put" do
        substitute = SubstAttr::Substitute.build(EntityCache::Store::Internal)

        test do
          refute(substitute.put?)
        end
      end

      context "Record Was Put" do
        put_record = Controls::Record.example

        substitute = SubstAttr::Substitute.build(EntityCache::Store::Internal)
        substitute.put(put_record)

        test do
          assert(substitute.put?)
          assert(substitute.put?(put_record))

          other_id = Identifier::UUID::Random.get
          other_record = Controls::Record.example(id: other_id)

          refute(substitute.put?(other_record))
        end
      end
    end
  end
end

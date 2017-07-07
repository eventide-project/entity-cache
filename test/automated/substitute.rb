require_relative './automated_init'

context "Substitute" do
  id = Controls::ID.example

  control_record = Controls::Record.example(id: id)

  context "Get" do
    substitute = SubstAttr::Substitute.build(EntityCache)

    substitute.add(
      id,
      control_record.entity,
      control_record.version,
      time: control_record.time,
      persisted_version: control_record.persisted_version,
      persisted_time: control_record.persisted_time
    )

    test "Returns added record" do
      record = substitute.get(id)

      assert(record == control_record)
    end
  end

  context "Put" do
    substitute = SubstAttr::Substitute.build(EntityCache)

    context "Nothing Is Put" do
      test "Predicate returns false" do
        refute(substitute) do
          put?
        end
      end
    end

    context "Record Is Put" do
      substitute.put(
        id,
        control_record.entity,
        control_record.version,
        time: control_record.time,
        persisted_version: control_record.persisted_version,
        persisted_time: control_record.persisted_time
      )

      test "Get returns nothing" do
        record = substitute.get(id)

        assert(record.nil?)
      end

      test "Predicate returns true" do
        assert(substitute.put?)

        assert(substitute) do
          put? do |record|
            record == control_record
          end
        end
      end
    end
  end
end

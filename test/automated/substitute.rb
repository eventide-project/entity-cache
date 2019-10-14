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
        refute(substitute.put?)
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

      context "Predicate" do
        context "No Block Argument" do
          test do
            assert(substitute.put?)
          end
        end

        context "Block Argument" do
          test "Record that was put is yielded to block" do
            record = nil

            substitute.put? do |r|
              record = r
            end

            assert(record == control_record)
          end

          context "Block Returns True" do
            test do
              assert(substitute.put? { true })
            end
          end

          context "Block Returns False" do
            test do
              refute(substitute.put? { false })
            end
          end
        end
      end
    end
  end
end

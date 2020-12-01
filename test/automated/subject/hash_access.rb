require_relative '../automated_init'

context "Subject" do
  context "Hash Access" do
    original_value = 'original data'
    override_value = 'override data'

    context "Hash Is Assigned Different Values for the Same Subject Keys" do
      hash = {}

      subject_1 = Controls::Subject.example
      subject_2 = Controls::Subject.example

      assert(subject_1.to_h == subject_2.to_h)
      refute(subject_1.equal?(subject_2))

      hash[subject_1] = original_value
      hash[subject_2] = override_value

      value = hash[subject_1]

      test "Both values are written to the same key" do
        comment "Value: #{value.inspect}"
        detail "Override Value: #{override_value.inspect}"
        detail hash.pretty_inspect

        assert(value == override_value)
      end
    end

    context "Hash Is Assigned Different Values for Different Subject Keys" do
      hash = {}

      subject_1 = Controls::Subject.example(random: true)
      subject_2 = Controls::Subject.example(random: true)

      refute(subject_1.to_h == subject_2.to_h)

      hash[subject_1] = original_value
      hash[subject_2] = override_value

      value = hash[subject_1]

      test "Values are written to different keys" do
        comment "Value: #{value.inspect}"
        detail "Original Value: #{original_value.inspect}"

        assert(value == original_value)
      end
    end
  end
end

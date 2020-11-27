require_relative '../automated_init'

context "Subject" do
  context "Hash Access" do
    specifier = Controls::Specifier.example

    subject_1 = Controls::Subject.example(specifier: specifier)
    subject_2 = Controls::Subject.example(specifier: specifier)

    assert(subject_1.to_h == subject_2.to_h)
    refute(subject_1.equal?(subject_2))

    context "Hash Is Assigned Different Values for the Same Subject Keys" do
      hash = {}

      override_value = 'override data'

      hash[subject_1] = 'original data'
      hash[subject_2] = override_value

      value = hash[subject_1]

      test "Both values are written to the same key" do
        comment "Value: #{value.inspect}"
        detail "Override Value: #{override_value.inspect}"

        assert(value == override_value)
      end
    end

    context "Hash Is Assigned Different Values for Different Subject Keys" do
      test "Values are written to different keys" do
        refute(true)
      end
    end
  end
end

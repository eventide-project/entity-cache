require_relative '../automated_init'

context "Subject" do
  context "Hash Access" do
    specifier = Controls::Specifier.example

    subject_1 = Controls::Subject.example(specifier: specifier)
    subject_2 = Controls::Subject.example(specifier: specifier)

    assert(subject_1 == subject_2)
    refute(subject_1.equal?(subject_2))

    context "Hash Is Assigned Different Values For Two Equivalent Subjects" do
      hash = {}

      control_value = 'other data'

      hash[subject_1] = 'some data'
      hash[subject_2] = control_value

      value = hash[subject_1]

      test "Second assignment overrides the first" do
        comment "Control value: #{control_value.inspect}"
        detail "Compare value: #{value.inspect}"

        assert(value == control_value)
      end
    end
  end
end

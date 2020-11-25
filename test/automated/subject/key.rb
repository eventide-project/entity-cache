require_relative '../automated_init'

context "Subject" do
  context "Hash Key" do
    context "Specifier" do
      specifier = Controls::Specifier.example

      subject = Controls::Subject.example(specifier: specifier)

      control_key = Controls::Subject::Key.example(specifier: specifier)

      key = subject.key

      test do
        comment "Control key: #{control_key.inspect}"
        detail "Compare key: #{key.inspect}"

        assert(key == control_key)
      end
    end

    context "No Specifier" do
      subject = Controls::Subject.example(specifier: :none)

      control_key = Controls::Subject::Key.example(specifier: :none)

      key = subject.key

      test do
        comment "Control key: #{control_key.inspect}"
        detail "Compare key: #{key.inspect}"

        assert(key == control_key)
      end
    end
  end
end

require_relative '../automated_init'

context "External Store" do
  context "Specifier" do
    control_specifier = Controls::Specifier.example

    external_store = Controls::Store::External.example(specifier: control_specifier, random: false)

    specifier = external_store.specifier

    test do
      comment specifier.inspect
      detail "Control Specifier: #{control_specifier.inspect}"

      assert(specifier == control_specifier)
    end
  end
end

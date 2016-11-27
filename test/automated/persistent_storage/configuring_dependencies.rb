require_relative '../automated_init'

context "Configuring dependencies" do
  example_cls = Class.new do
    include EntityCache::Storage::Persistent

    attr_accessor :dependencies_configured

    def configure(session: nil)
      self.dependencies_configured = true
    end

    def dependencies_configured?
      dependencies_configured
    end
  end

  test do
    instance = example_cls.build :some_subject

    assert instance.dependencies_configured?
  end
end

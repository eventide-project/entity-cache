require_relative '../bench_init'

context "Configuring dependencies" do
  example_cls = Class.new do
    include EntityCache::Storage::Permanent

    attr_accessor :dependencies_configured

    def configure_dependencies
      self.dependencies_configured = true
    end

    def dependencies_configured?
      dependencies_configured
    end
  end

  test do
    instance = example_cls.build

    assert instance.dependencies_configured?
  end
end

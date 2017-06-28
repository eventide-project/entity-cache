require_relative '../../automated_init'

context "Persistent Store" do
  context "Null" do
    context "Get" do
      id = Controls::ID.example

      subject = Controls::Subject.example

      persistent_store = EntityCache::Store::Persistent::Null.build(subject)

      entity, version, time = nil, nil, nil

      get_proc = proc { entity, version, time = persistent_store.get(id) }

      test "No error is raised" do
        refute get_proc do
          raises_error?
        end
      end

      test "Entity is nil" do
        assert(entity.nil?)
      end

      test "Version is nil" do
        assert(version.nil?)
      end

      test "Time is nil" do
        assert(time.nil?)
      end
    end
  end
end

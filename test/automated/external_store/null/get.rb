require_relative '../../automated_init'

context "External Store" do
  context "Null" do
    context "Get" do
      id = Controls::ID.example

      subject = Controls::Subject.example

      external_store = EntityCache::Store::External::Null.build(subject)

      entity, version, time = nil, nil, nil

      get_proc = proc {  }

      test "No error is raised" do
        refute_raises do
          entity, version, time = external_store.get(id)
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

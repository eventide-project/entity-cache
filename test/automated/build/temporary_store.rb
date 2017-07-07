require_relative '../automated_init'

context "Build" do
  context "Temporary Store" do
    subject = Controls::Subject.example

    context "No Scope" do
      entity_cache = Fixtures::Environment.() do
        EntityCache.build(subject)
      end

      temporary_store = entity_cache.temporary_store

      test "Default scope is selected" do
        scope_class = EntityCache::Store::Temporary::Build.default_scope_class

        assert(temporary_store.instance_of?(scope_class))
      end

      test "Subject" do
        assert(temporary_store.subject == subject)
      end
    end

    context "Scope" do
      entity_cache = Fixtures::Environment.() do
        EntityCache.build(subject, scope: :exclusive)
      end

      temporary_store = entity_cache.temporary_store

      test "Specified scope is chosen" do
        scope_class = EntityCache::Store::Temporary::Scope::Exclusive

        assert(temporary_store.instance_of?(scope_class))
      end

      test "Subject" do
        assert(temporary_store.subject == subject)
      end
    end
  end
end

require_relative '../../automated_init'

context "Internal Store" do
  context "Scope Choice" do
    subject = Controls::Subject.example

    context "Default" do
      internal_store = Fixtures::Environment.() do
        EntityCache::Store::Internal::Build.(subject)
      end

      test "Thread" do
        assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Thread))
      end
    end

    context "Exclusive" do
      context "Selected By Argument" do
        internal_store = EntityCache::Store::Internal::Build.(subject, scope: :exclusive)

        test do
          assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Exclusive))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'exclusive') do
          internal_store = EntityCache::Store::Internal::Build.(subject)

          test do
            assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Exclusive))
          end
        end
      end
    end

    context "Thread" do
      context "Selected By Argument" do
        internal_store = EntityCache::Store::Internal::Build.(subject, scope: :thread)

        test do
          assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Thread))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'thread') do
          internal_store = EntityCache::Store::Internal::Build.(subject)

          test do
            assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Thread))
          end
        end
      end
    end

    context "Global" do
      context "Selected By Argument" do
        internal_store = EntityCache::Store::Internal::Build.(subject, scope: :global)

        test do
          assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Global))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'global') do
          internal_store = EntityCache::Store::Internal::Build.(subject)

          test do
            assert(internal_store.instance_of?(EntityCache::Store::Internal::Scope::Global))
          end
        end
      end
    end

    context "Unknown" do
      test "Raises error" do
        assert_raises(EntityCache::Store::Internal::Build::ScopeError) do
          EntityCache::Store::Internal::Build.(subject, scope: :unknown)
        end
      end
    end
  end
end

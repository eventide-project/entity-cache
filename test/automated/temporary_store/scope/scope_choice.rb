require_relative '../../automated_init'

context "Temporary Store" do
  context "Scope Choice" do
    subject = Controls::Subject.example

    context "Default" do
      temporary_store = EntityCache::Store::Temporary::Build.(subject)

      test "Thread" do
        assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Thread))
      end
    end

    context "Exclusive" do
      context "Selected By Argument" do
        temporary_store = EntityCache::Store::Temporary::Build.(subject, scope: :exclusive)

        test do
          assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Exclusive))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'exclusive') do
          temporary_store = EntityCache::Store::Temporary::Build.(subject)

          test do
            assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Exclusive))
          end
        end
      end
    end

    context "Thread" do
      context "Selected By Argument" do
        temporary_store = EntityCache::Store::Temporary::Build.(subject, scope: :thread)

        test do
          assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Thread))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'thread') do
          temporary_store = EntityCache::Store::Temporary::Build.(subject)

          test do
            assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Thread))
          end
        end
      end
    end

    context "Global" do
      context "Selected By Argument" do
        temporary_store = EntityCache::Store::Temporary::Build.(subject, scope: :global)

        test do
          assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Global))
        end
      end

      context "Selected By ENV" do
        Fixtures::Environment.('ENTITY_CACHE_SCOPE' => 'global') do
          temporary_store = EntityCache::Store::Temporary::Build.(subject)

          test do
            assert(temporary_store.instance_of?(EntityCache::Store::Temporary::Scope::Global))
          end
        end
      end
    end

    context "Unknown" do
      test "Raises error" do
        assert proc { EntityCache::Store::Temporary::Build.(subject, scope: :unknown) } do
          raises_error?(EntityCache::Store::Temporary::Build::ScopeError)
        end
      end
    end
  end
end

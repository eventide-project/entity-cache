require_relative '../../automated_init'

context "Cache scope selection" do
  subject = Controls::Subject.example

  test "Exclusive" do
    storage = EntityCache::Storage::Temporary::Build.(subject, scope: :exclusive)

    assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Exclusive)
  end

  test "Thread" do
    storage = EntityCache::Storage::Temporary::Build.(subject, scope: :thread)

    assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Thread)
  end

  test "Error if unknown" do
    assert proc { EntityCache::Storage::Temporary::Build.(subject, scope: :unknown) } do
      raises_error? EntityCache::Storage::Temporary::Scope::Error
    end
  end

  context "Default" do
    env_var_name = EntityCache::Storage::Temporary::Scope::Defaults::Name.env_var_name
    saved_scope_setting = ENV[env_var_name]

    test "Thread if otherwise unspecified" do
      ENV[env_var_name] = nil

      storage = EntityCache::Storage::Temporary::Build.(subject)

      assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Thread)

      ENV[env_var_name] = saved_scope_setting
    end

    test "Can be specified with the ENTITY_CACHE_SCOPE environment variable" do
      ENV[env_var_name] = 'exclusive'

      storage = EntityCache::Storage::Temporary::Build.(subject)

      assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Exclusive)

      ENV[env_var_name] = saved_scope_setting
    end
  end
end

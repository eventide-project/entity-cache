require_relative '../../bench_init'

context "Cache scope selection" do
  test "Exclusive" do
    storage = EntityCache::Storage::Temporary::Factory.(:some_subject, scope: :exclusive)

    assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Exclusive)
  end

  test "Shared" do
    storage = EntityCache::Storage::Temporary::Factory.(:some_subject, scope: :shared)

    assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Shared)
  end

  test "Error if unknown" do
    assert proc { EntityCache::Storage::Temporary::Factory.(:some_subject, scope: :unknown) } do
      raises_error? EntityCache::Storage::Temporary::Scope::Error
    end
  end

  context "Default" do
    env_var_name = EntityCache::Storage::Temporary::Scope::Defaults::Name.env_var_name
    saved_scope_setting = ENV[env_var_name]

    test "Shared if otherwise unspecified" do
      ENV[env_var_name] = nil

      storage = EntityCache::Storage::Temporary::Factory.(:some_subject)

      assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Shared)

      ENV[env_var_name] = saved_scope_setting
    end

    test "Can be specified with the ENTITY_CACHE_SCOPE environment variable" do
      ENV[env_var_name] = 'exclusive'

      storage = EntityCache::Storage::Temporary::Factory.(:some_subject)

      assert storage.is_a?(EntityCache::Storage::Temporary::Scope::Exclusive)

      ENV[env_var_name] = saved_scope_setting
    end
  end
end

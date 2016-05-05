require_relative '../../bench_init'

context "Cache scope selection" do
  test "Exclusive" do
    storage = EntityCache::Storage::Cache::Factory.(:some_subject, scope: :exclusive)

    assert storage.is_a?(EntityCache::Storage::Cache::Scope::Exclusive)
  end

  test "Shared" do
    storage = EntityCache::Storage::Cache::Factory.(:some_subject, scope: :shared)

    assert storage.is_a?(EntityCache::Storage::Cache::Scope::Shared)
  end

  test "Error if unknown" do
    assert proc { EntityCache::Storage::Cache::Factory.(:some_subject, scope: :unknown) } do
      raises_error? EntityCache::Storage::Cache::Scope::Error
    end
  end

  context "Default" do
    test "Shared if otherwise unspecified" do
      storage = EntityCache::Storage::Cache::Factory.(:some_subject)

      assert storage.is_a?(EntityCache::Storage::Cache::Scope::Shared)
    end

    test "Can be specified with the ENTITY_CACHE_SCOPE environment variable" do
      env_var_name = EntityCache::Storage::Cache::Scope::Defaults::Name.env_var_name

      saved_scope_setting = ENV[env_var_name]
      ENV[env_var_name] = 'exclusive'

      storage = EntityCache::Storage::Cache::Factory.(:some_subject)

      assert storage.is_a?(EntityCache::Storage::Cache::Scope::Exclusive)

      ENV[env_var_name] = saved_scope_setting
    end
  end
end

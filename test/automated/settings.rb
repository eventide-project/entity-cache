require_relative 'automated_init'

context "Settings" do
  context "Settings file does not exist" do
    saved_settings_file_path = EntityCache::Settings.path

    EntityCache::Settings.path = SecureRandom.hex

    settings = EntityCache::Settings.build

    test "Write behind delay is not specified" do
      write_behind_delay = settings.get :write_behind_delay

      assert write_behind_delay == nil
    end

    EntityCache::Settings.path = saved_settings_file_path
  end
end

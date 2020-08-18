module Fixtures
  module Environment
    def self.call(env=nil, &block)
      env ||= {}

      if RUBY_ENGINE == 'mruby'
        old_env = ENV.to_hash
      else
        old_env = ENV.to_h
      end

      begin
        replace_env(env)

        block.()

      ensure
        replace_env(old_env)
      end
    end

    def self.replace_env(env)
      ENV.clear

      env.each do |key, value|
        ENV[key] = value
      end
    end
  end
end

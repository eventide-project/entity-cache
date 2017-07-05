module Fixtures
  module Environment
    def self.call(env=nil, &block)
      env ||= {}

      old_env = ENV.to_h

      begin
        ENV.replace(env)

        block.()

      ensure
        ENV.replace(old_env)
      end
    end
  end
end

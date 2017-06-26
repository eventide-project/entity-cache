ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'securerandom'

require 'entity_cache/controls'

fail if defined?(EntityCache::Controls); class EntityCache; module Controls; end; end
Controls = EntityCache::Controls

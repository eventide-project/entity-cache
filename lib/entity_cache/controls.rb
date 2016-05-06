require 'controls'

require 'entity_cache/controls/entity'
require 'entity_cache/controls/record'
require 'entity_cache/controls/storage/persistent'
require 'entity_cache/controls/storage/temporary'
require 'entity_cache/controls/version'
require 'entity_cache/controls/write_behind_delay'

EntityCache::Controls::Storage::Persistent::Example.activate

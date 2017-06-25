require 'configure'; Configure.activate
require 'settings'; Settings.activate
require 'telemetry'
require 'log'
require 'virtual'; Virtual.activate

require 'entity_cache/log'

require 'entity_cache/error'

require 'entity_cache/record'

require 'entity_cache/storage/persistent'
require 'entity_cache/storage/persistent/none'
require 'entity_cache/storage/persistent/substitute'
require 'entity_cache/storage/persistent/telemetry'

require 'entity_cache/storage/temporary'
require 'entity_cache/storage/temporary/build'
require 'entity_cache/storage/temporary/scope/defaults'
require 'entity_cache/storage/temporary/scope/error'
require 'entity_cache/storage/temporary/scope/exclusive'
require 'entity_cache/storage/temporary/scope/shared'

require 'entity_cache/defaults'
require 'entity_cache/entity_cache'
require 'entity_cache/substitute'

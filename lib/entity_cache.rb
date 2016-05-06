require 'configure'; Configure.activate
require 'settings'; Settings.activate
require 'telemetry'
require 'telemetry/logger'
require 'virtual'; Virtual.activate

require 'entity_cache/record'

require 'entity_cache/storage/persistent'
require 'entity_cache/storage/persistent/defaults'
require 'entity_cache/storage/persistent/factory'
require 'entity_cache/storage/persistent/none'
require 'entity_cache/storage/persistent/substitute'
require 'entity_cache/storage/persistent/telemetry'

require 'entity_cache/storage/temporary'
require 'entity_cache/storage/temporary/factory'
require 'entity_cache/storage/temporary/scope'
require 'entity_cache/storage/temporary/scope/exclusive'
require 'entity_cache/storage/temporary/scope/shared'

require 'entity_cache/entity_cache'
require 'entity_cache/substitute'

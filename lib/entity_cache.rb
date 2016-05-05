require 'telemetry'
require 'telemetry/logger'
require 'virtual'; Virtual.activate

require 'entity_cache/record'
require 'entity_cache/storage/permanent'
require 'entity_cache/storage/permanent/telemetry'
require 'entity_cache/storage/temporary'
require 'entity_cache/storage/temporary/factory'
require 'entity_cache/storage/temporary/scope'
require 'entity_cache/storage/temporary/scope/exclusive'
require 'entity_cache/storage/temporary/scope/shared'

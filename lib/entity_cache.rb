require 'configure'; Configure.activate
require 'message_store'
require 'settings'
require 'telemetry'

require 'entity_cache/log'

require 'entity_cache/record'
require 'entity_cache/record/destructure'
require 'entity_cache/record/log_text'
require 'entity_cache/record/transformer'

require 'entity_cache/store/persistent'
require 'entity_cache/store/persistent/null'
require 'entity_cache/store/persistent/substitute'
require 'entity_cache/store/persistent/telemetry'

require 'entity_cache/store/temporary'
require 'entity_cache/store/temporary/build'
require 'entity_cache/store/temporary/build/defaults'
require 'entity_cache/store/temporary/scope/exclusive'
require 'entity_cache/store/temporary/scope/global'
require 'entity_cache/store/temporary/scope/thread'

require 'entity_cache/entity_cache'

require 'configure'; Configure.activate
require 'message_store'
require 'settings'
require 'telemetry'

require 'entity_cache/log'

require 'entity_cache/defaults'

require 'entity_cache/record'
require 'entity_cache/record/destructure'
require 'entity_cache/record/log_text'
require 'entity_cache/record/transformer'

require 'entity_cache/store/external'
require 'entity_cache/store/external/null'
require 'entity_cache/store/external/substitute'
require 'entity_cache/store/external/telemetry'

require 'entity_cache/store/internal'
require 'entity_cache/store/internal/build'
require 'entity_cache/store/internal/build/defaults'
require 'entity_cache/store/internal/scope/exclusive'
require 'entity_cache/store/internal/scope/global'
require 'entity_cache/store/internal/scope/thread'
require 'entity_cache/store/internal/substitute'

require 'entity_cache/entity_cache'
require 'entity_cache/substitute'

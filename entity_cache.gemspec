# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-entity_cache'
  s.version = '0.11.1.3'
  s.summary = 'Cache of entities retrieved by an entity-store, with in-memory temporary and on-disk permanent storage options'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/entity-cache'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-configure'
  s.add_runtime_dependency 'evt-clock'
  s.add_runtime_dependency 'evt-identifier-uuid'
  s.add_runtime_dependency 'evt-settings'
  s.add_runtime_dependency 'evt-telemetry'
  s.add_runtime_dependency 'evt-log'
  s.add_runtime_dependency 'evt-virtual'

  s.add_development_dependency 'test_bench'
end

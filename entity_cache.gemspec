# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'entity_cache'
  s.version = '0.6.1.0'
  s.summary = 'Entity cache'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/entity-cache'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'configure'
  s.add_runtime_dependency 'clock'
  s.add_runtime_dependency 'identifier-uuid'
  s.add_runtime_dependency 'settings'
  s.add_runtime_dependency 'telemetry'
  s.add_runtime_dependency 'telemetry-logger'
  s.add_runtime_dependency 'virtual'

  s.add_development_dependency 'test_bench'
end

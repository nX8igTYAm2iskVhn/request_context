# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'request_context/version'

Gem::Specification.new do |s|
  s.name = 'request_context'
  s.version = RequestContext::VERSION
  s.required_ruby_version = '~> 1.9'

  s.summary = 'RequestContext helper gem'
  s.authors = %w[nX8igTYAm2iskVhn]
  s.email = 'nX8igTYAm2iskVhn-dev@nX8igTYAm2iskVhn.com'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'railties', '>= 3.2'
  s.add_development_dependency 'i18n', '~> 0.6.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'

  s.files = Dir.glob('{lib}/**/*') + %w(README.md)
end

# -*- encoding: utf-8 -*-

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fafuse/version"

Gem::Specification.new do |gem|
  gem.name          = "fafuse"
  gem.version       = FAFuse::VERSION
  gem.authors       = ["Victor Goya"]
  gem.email         = ["phorque@phorque.it"]
  gem.description   = "Fuse wrapper for an art website"
  gem.summary       = "Fuse wrapper for an art website"
  gem.homepage      = "https://phorque.it"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = %w(fafuse)
  gem.require_paths = ["lib"]
  gem.bindir        = 'bin'

  gem.licenses      = ["MIT"]

  gem.required_ruby_version = "~> 2.0"

  gem.add_dependency 'rfuse', '~> 1.1', '>= 1.1.2'
  gem.add_dependency 'nokogiri', '~> 1.7', '>= 1.7.2'
  gem.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  gem.add_development_dependency "byebug"
end

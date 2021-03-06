# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "api_mapper/version"

Gem::Specification.new do |spec|
  spec.name          = "api_mapper"
  spec.version       = ApiMapper::VERSION
  spec.authors       = ["Marcin Ciunelis"]
  spec.email         = ["marcin.ciunelis@gmail.com"]

  spec.summary       = "api_mapper converts API resources in to ruby objects"
  spec.description   = ""
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1"

  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "json", "~> 1.8.3"
  spec.add_dependency "addressable", "~> 2.3.6"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.21.0"
  spec.add_development_dependency "virtus", "~> 1.0.5"
  spec.add_development_dependency "rubocop", "~> 0.33"
  spec.add_development_dependency "rom-mapper", "~> 0.2.0"
  spec.add_development_dependency "rom-model"
  spec.add_development_dependency "rom"
end

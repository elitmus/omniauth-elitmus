# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/elitmus/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-elitmus"
  spec.version       = Omniauth::Elitmus::VERSION
  spec.authors       = ["Shrey Patel"]
  spec.email         = ["shrey@elitmus.com"]
  spec.summary       = 'Elitmus OAuth2 Strategy for OmniAuth'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  
end

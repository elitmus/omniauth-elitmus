# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/elitmus/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-elitmus"
  spec.version       = Omniauth::Elitmus::VERSION
  spec.authors       = ["Shrey Patel"]
  spec.email         = ["shrey@elitmus.com"]
  spec.summary       = 'eLitmus OAuth2 Strategy for OmniAuth'
  spec.homepage      = "https://www.eLitmus.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'

  spec.add_development_dependency 'minitest', '~> 5.5.1'
  spec.add_development_dependency 'mocha', '~>1.1.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
end

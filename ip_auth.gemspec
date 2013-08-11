# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ip_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "ip_auth"
  spec.version       = IpAuth::VERSION
  spec.authors       = ["Anand Mohanaveeramani"]
  spec.email         = ["anand.mohanaveeramani@gmail.com"]
  spec.description   = %q{App based IP authorization system}
  spec.summary       = %q{Customizable IP authorization system based on application's models and logics}
  spec.homepage      = "https://github.com/anand-mohanaveeramani/ip_auth"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3'
  spec.add_dependency 'ipaddress', '0.8.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "ammeter"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "pg"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ip_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "ip_auth"
  spec.version       = IpAuth::VERSION
  spec.authors       = ["Anand Mohanaveeramani"]
  spec.email         = ["anand.mohanaveeramani@gmail.com"]
  spec.description   = %q{App based IP authentication system}
  spec.summary       = %q{Customizable IP authentication system based on application's model and logic}
  spec.homepage      = "https://github.com/anand-mohanaveeramani/ip_auth"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "ammeter"
end

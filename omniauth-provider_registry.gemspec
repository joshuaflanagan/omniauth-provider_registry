# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/provider_registry/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-provider_registry"
  spec.version       = OmniAuth::ProviderRegistry::VERSION
  spec.authors       = ["Joshua Flanagan"]
  spec.email         = ["joshuaflanagan@gmail.com"]
  spec.summary       = %q{Provides access to your configured OmniAuth providers}
  spec.homepage      = "https://github.com/joshuaflanagan/omniauth-provider_registry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

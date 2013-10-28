# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bib/opsworks/version'

Gem::Specification.new do |spec|
  spec.name          = "Bib::Opsworks"
  spec.version       = Bib::Opsworks::VERSION
  spec.authors       = ["fh"]
  spec.email         = ["fh-gem@fholzhauer.de"]
  spec.homepage      = "https://github.com/fh/OpsworksEasybibGem"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'json'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0.8"
  spec.add_development_dependency "coveralls"
end

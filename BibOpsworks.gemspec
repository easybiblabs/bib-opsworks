# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bib/opsworks/version'

Gem::Specification.new do |spec|
  spec.name          = 'BibOpsworks'
  spec.version       = Bib::Opsworks::VERSION
  spec.authors       = %w(fh tillk gilleyj)
  spec.email         = ['fh-gem@fholzhauer.de']
  spec.homepage      = 'https://github.com/easybiblabs/bib-opsworks'
  spec.summary       = 'Tools wrapper for AWS Opsworks Deploys'

  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json'
  spec.add_dependency 'hipchat', '1.5.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.0.8'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
end

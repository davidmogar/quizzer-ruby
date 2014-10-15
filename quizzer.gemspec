# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quizzer/version'

Gem::Specification.new do |spec|
  spec.name          = "quizzer"
  spec.version       = Quizzer::VERSION
  spec.authors       = ["David Moreno Garc\xC3\xADa"]
  spec.email         = ["david.mogar@gmail.com"]
  spec.summary       = %q{Assessments validator}
  spec.description   = %q{Simple application to parse and validate custom assesments JSON files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quizzer/version'

Gem::Specification.new do |spec|
  spec.name          = "quizzer"
  spec.version       = Quizzer::VERSION
  spec.authors       = ["David Moreno García"]
  spec.email         = ["david.mogar@gmail.com"]
  spec.summary       = %q{Assessment parser}
  spec.description   = %q{Simple application to parse and validate custom assessments JSON files}
  spec.homepage      = "https://github.com/davidmogar/quizzer-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['quizzer']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

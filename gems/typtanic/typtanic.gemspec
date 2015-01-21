# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typtanic/version'

Gem::Specification.new do |spec|
  spec.name          = "typtanic"
  spec.version       = Typtanic::VERSION
  spec.authors       = ["Peter Saxton"]
  spec.email         = ["peterhsaxton@gmail.com"]
  spec.summary       = %q{Lots of good stuff on types}
  spec.description   = %q{ Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.4.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.0.6"
end

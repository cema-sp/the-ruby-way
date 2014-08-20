# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'my_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "my_gem"
  spec.version       = MyGem::VERSION
  spec.authors       = ["cema-sp"]
  spec.email         = ["cema.rus@gmail.com"]
  spec.summary       = %q{My gem - just an example}
  spec.description   = %q{This is a description of my first gem, it may be long or short as you wish}
  spec.homepage      = "http://cema.net63.net/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

#  spec.require_ruby_version = ">= 2.0"

  spec.add_development_dependency "bundler", "~> 1.7"
#  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "json", [">=1.0"]
end

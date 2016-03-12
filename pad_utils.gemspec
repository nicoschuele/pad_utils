# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pad_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "pad_utils"
  spec.version       = PadUtils::VERSION
  spec.required_ruby_version = '>= 2.2.2'
  spec.authors       = ["Nico Schuele"]
  spec.email         = ["help@padstone.io"]
  spec.summary       = "PadUtils is a simple gem containing common utilities and shortcuts"
  spec.description   = "PadUtils is a simple gem containing common utilities and shortcuts. It is used in the Padstone app builder but can be embedded in any other Ruby project."
  spec.homepage      = "http://padstone.io"
  spec.license       = "Apache-2.0"
  spec.files         = Dir["{lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  spec.executables   << 'padutils'
  spec.require_paths = ["lib"]
  spec.add_dependency 'json', '>= 1.8.3', '< 1.9'
  spec.add_dependency 'httparty', '>= 0.13.7', '< 0.14'
end

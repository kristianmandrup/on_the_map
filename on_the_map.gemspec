# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'on_the_map/version'

Gem::Specification.new do |spec|
  spec.name          = "on_the_map"
  spec.version       = OnTheMap::VERSION
  spec.authors       = ["Kristian Mandrup"]
  spec.date          = "2013-03-13"
  spec.summary       = "Add map, address and geocoding functionality to your Mongoid models"
  spec.description   = "Makes it easy to add functionality to models related to geocoding, addressing and placing them as pins on a map"
  spec.email         = "kmandrup@gmail.com"
  spec.homepage      = "https://github.com/kristianmandrup/on_the_map"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails',         '>= 3.2'

  spec.add_dependency 'mongoid',       '>= 3.1'

  spec.add_dependency 'sugar-high',    '~> 0.7.3'
  spec.add_dependency 'hashie',        '>= 2.0'
  spec.add_dependency 'concerned',     '>= 0.1.5'

  spec.add_development_dependency 'rspec-rails', '>= 2.12'
end


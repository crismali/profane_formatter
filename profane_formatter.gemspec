# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "profane_formatter/version"

Gem::Specification.new do |spec|
  spec.name          = "profane_formatter"
  spec.version       = ProfaneFormatter::VERSION
  spec.authors       = ["Michael Crismali"]
  spec.email         = ["michael.crismali@gmail.com"]
  spec.summary       = "Formats your Rspec spec results in a profane way."
  spec.description   = "Formats your Rspec spec results in a profane way, obviously."
  spec.homepage      = "https://github.com/crismali/profane_formatter"
  spec.license       = "Apache"

  spec.files         = Dir["LICENCE", "README.md", "lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

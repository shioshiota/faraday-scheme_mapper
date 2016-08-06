# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday/scheme_mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "faraday-scheme_mapper"
  spec.version       = Faraday::SchemeMapper::VERSION
  spec.authors       = ["Tetsuya Shiota"]
  spec.email         = ["tetsuya.shiota.1231@gmail.com"]

  spec.summary       = %q{Faraday middleware to manage mapping schemes(https,http) to each endpoint.}
  spec.description   = %q{This gem is a Faraday middleware that manages mapping schemes(https,http) to each endpoints. You can switch http/https more easily.}
  spec.homepage      = "https://github.com/shioshiota/faraday-scheme_mapper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

   spec.add_dependency "faraday"
end

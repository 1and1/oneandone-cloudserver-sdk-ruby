# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "1and1"
  spec.version       = "1.2.0"
  spec.authors       = ["Tyler Burkhardt (stackpointcloud.com)"]
  spec.email         = "tyler@stackpointcloud.com"
  spec.summary       = "Official 1&1 SDK for Ruby"
  spec.description   = "The 1&1 SDK for Ruby provides integration with the 1&1 cloud environment over the available REST API."
  spec.homepage      = "https://github.com/1and1/oneandone-cloudserver-sdk-ruby"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "excon", "~> 0.44"
  spec.add_runtime_dependency "json", "~> 1.8"
end

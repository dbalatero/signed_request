# -*- encoding: utf-8 -*-
require File.expand_path('../lib/signed_request/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Balatero", "Rob Hanlon"]
  gem.email         = ["david@mediapiston.com", "rob@mediapiston.com"]
  gem.description   = %q{A simple gem for signing/verifying an HTTP request that has gone over the wire.}
  gem.summary       = %q{A simple gem for signing/verifying an HTTP request that has gone over the wire.}
  gem.homepage      = "http://www.mediapiston.com/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.name          = "signed_request"
  gem.require_paths = ["lib"]
  gem.version       = SignedRequest::VERSION

  gem.add_development_dependency 'rspec', '2.10.0'
end

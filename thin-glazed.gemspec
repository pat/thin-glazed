# -*- encoding: utf-8 -*-
require File.expand_path('../lib/thin/glazed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Pat Allan']
  gem.email         = ['pat@freelancing-gods.com']
  gem.description   = 'SSL Proxy for HTTP Thin servers'
  gem.summary       = 'SSL Proxy for HTTP Thin servers that forwards on HTTPS requests to a Thin server with the SSL layer removed.'
  gem.homepage      = 'https://github.com/freelancing-god/thin-glazed'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |file|
    File.basename(file)
  }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'thin-glazed'
  gem.require_paths = ['lib']
  gem.version       = Thin::Glazed::VERSION

  gem.add_runtime_dependency 'eventmachine', '>= 0'
  gem.add_runtime_dependency 'thin',         '>= 1.3.1'
end

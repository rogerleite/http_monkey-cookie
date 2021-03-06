# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'http_monkey/cookie/version'

Gem::Specification.new do |gem|
  gem.name          = "http_monkey-cookie"
  gem.version       = HttpMonkey::Cookie::VERSION
  gem.authors       = ["Roger Leite"]
  gem.email         = ["roger.barreto@gmail.com"]
  gem.description   = %q{Rack middleware to support magic cookie on clients}
  gem.summary       = %q{Rack middleware to support magic cookie on clients}
  gem.homepage      = "https://github.com/rogerleite/http_monkey-cookie"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "http_monkey", "~> 0.0"
  # https://github.com/rogerleite/cookiejar/tree/http_monkey, branch "http_monkey"
  # Manually copied from git repository to lib folder here. It's a shame! I know.
  # $ cp -R ../cookiejar/lib/* lib/

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest", "~> 3"
  gem.add_development_dependency "minitest-reporters", "~> 0.7.0"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "minion_server"
end

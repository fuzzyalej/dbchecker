# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbchecker/version'

Gem::Specification.new do |spec|
  spec.name          = "dbchecker"
  spec.version       = Dbchecker::VERSION
  spec.authors       = ["Alejandro Andres"]
  spec.email         = ["alej@redradix.com"]
  spec.description   = %q{Check your database consistency}
  spec.summary       = %q{This gem offers a set of tools to check the consistency of your database}
  spec.homepage      = "http://github.com/redradix/dbchecker"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "database_cleaner"

  spec.add_dependency "rails", "~> 3.2.13"
end

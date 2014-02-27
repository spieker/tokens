# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tokens/version"

Gem::Specification.new do |s|
  s.name        = "ar-tokens"
  s.version     = Tokens::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Spieker"]
  s.email       = ["p.spieker@duenos.de"]
  s.homepage    = "https://github.com/spieker/tokens"
  s.summary     = %q{Generating tokens on ruby objects and active record columns}
  s.description = %q{This gem lets you easily generate tokens on ruby objects and provides additional methods on ActiveRecord::Base to generate tokens on records}

  s.rubyforge_project = "tokens"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord'
end

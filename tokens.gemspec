# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tokens/version"

Gem::Specification.new do |s|
  s.name        = "tokens"
  s.version     = Tokens::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Spieker"]
  s.email       = ["p.spieker@duenos.de"]
  s.homepage    = ""
  s.summary     = %q{Generating tokens on ruby objects and for active record columns}
  s.description = %q{This gem lets you easily generate tokens on ruby objects and provides additional methods on ActiveRecord::Base for generating tokens for records}

  s.rubyforge_project = "tokens"
  
  s.add_dependency 'base58'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord'
end

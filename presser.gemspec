# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "presser/version"

Gem::Specification.new do |s|
  s.name        = "presser"
  s.version     = Presser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Jeff Roush"
  s.email       = "jeff@jeffroush.com"
  s.homepage    = ""
  s.summary     = %q{A Ruby-based cli WordPress client}
  s.description = %q{Nothing concrete yet -- just noodling.}

  s.rubyforge_project = "presser"

  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = "presser"
  s.require_paths = ["lib"]
end

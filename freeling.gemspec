# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freeling/version"

Gem::Specification.new do |s|
  s.name        = "freeling"
  s.version     = FreeLing::VERSION
  s.authors     = ["Damián Silvani"]
  s.email       = ["munshkr@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{FreeLing bindings for Ruby}
  s.description = %q{FreeLing bindings for Ruby, using SWIG to automatically generate a Ruby wrapper}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.extensions = ["ext/libmorfo_ruby/extconf.rb"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "rake-compiler", "~> 0.7.9"
  # s.add_runtime_dependency "rest-client"
end

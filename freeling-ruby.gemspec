# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freeling-ruby/version"

Gem::Specification.new do |s|
  s.name        = "freeling-ruby"
  s.version     = FreeLing::Ruby::VERSION
  s.authors     = ["Damián Silvani"]
  s.email       = ["munshkr@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "freeling-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.extensions = FileList["ext/**/extconf.rb"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake-compiler", "~> 0.7.9"
  # s.add_runtime_dependency "rest-client"
end

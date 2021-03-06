# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freeling/version"

Gem::Specification.new do |s|
  s.name        = "freeling"
  s.version     = FreeLing::VERSION
  s.authors     = ["Damián Silvani"]
  s.email       = ["munshkr@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby bindings for FreeLing 3.0+, an open source NLP tool suite.}
  s.description = <<-EOM
    FreeLing is an open source suite of language analyzers written in C++.
    The main services offered are: Text tokenization, sentence splitting,
    morphological analysis, suffix treatment, retokenization of clitic pronouns,
    flexible multiword recognition, contraction splitting, probabilistic
    prediction of unkown word categories, named entity detection, recognition of
    dates, numbers, ratios, currency, and physical magnitudes (speed, weight,
    temperature, density, etc.), PoS tagging, chart-based shallow parsing, named
    entity classification, WordNet based sense annotation and disambiguation,
    rule-based dependency parsing, and nominal correference resolution.
    Currently supported languages are Spanish, Catalan, Galician, Italian,
    English, Welsh, Portuguese, and Asturian.
    EOM

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.platform = Gem::Platform::RUBY
  s.extensions = ["ext/freeling_ruby/extconf.rb"]

  s.add_dependency "rice"

  s.add_development_dependency "rake-compiler"
  s.add_development_dependency "minitest"
end

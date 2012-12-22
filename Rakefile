require "bundler/gem_tasks"
require "rake/extensiontask"
require "rake/testtask"

Rake::ExtensionTask.new("freeling_ruby")

CLOBBER.include "ext/freeling_ruby/Makefile", "ext/freeling_ruby/mkmf.log"

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList["spec/**/*_spec.rb"]
  t.verbose = false
end

task :set_compiler_var do
  ENV["COMPILE_TEST"] = "1"
end

task :test => [:set_compiler_var, :clean, :compile]
task :default => :test

require 'rake/dsl_definition'
require 'rake/extensiontask'
require 'bundler/gem_tasks'

# Remove SWIG wrappers
CLOBBER.include 'ext/freeling_ruby/*_wrap.cxx',
                'ext/freeling_ruby/Makefile',
                'ext/freeling_ruby/mkmf.log'

Rake::ExtensionTask.new('freeling_ruby') do |ext|
  ext.source_pattern = '*.i'
end

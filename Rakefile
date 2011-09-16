require 'rake/dsl_definition'
require 'rake/extensiontask'
require 'bundler/gem_tasks'

# Remove SWIG wrappers
CLOBBER.include 'ext/libmorfo_ruby/*_wrap.cxx',
                'ext/libmorfo_ruby/Makefile',
                'ext/libmorfo_ruby/mkmf.log'

Rake::ExtensionTask.new('libmorfo_ruby') do |ext|
  ext.source_pattern = '*.i'
end

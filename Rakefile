require 'rake/dsl_definition'
require 'rake/extensiontask'
require 'bundler/gem_tasks'

# Remove SWIG wrappers
CLOBBER.include 'ext/libmorfo/*_wrap.cxx',
                'ext/libmorfo/Makefile',
                'ext/libmorfo/mkmf.log'

Rake::ExtensionTask.new('libmorfo') do |ext|
  ext.source_pattern = '*.{c,cpp,i}'
end

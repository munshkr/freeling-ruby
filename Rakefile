require 'bundler/gem_tasks'
require 'rake/extensiontask'

# Remove SWIG wrappers
CLOBBER.include 'ext/**/*_wrap.cxx',
                'ext/**/Makefile',
                'ext/**/mkmf.log'

Rake::ExtensionTask.new('freeling') do |ext|
  ext.source_pattern = '*.{c,cpp,i}'
end

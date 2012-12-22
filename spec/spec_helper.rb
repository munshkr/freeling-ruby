$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "rubygems" unless defined?(Gem)
require "bundler/setup"

# Test dependencies
require "minitest/spec"
require "minitest/autorun"

begin
  require "turn/autorun"
rescue LoadError
end

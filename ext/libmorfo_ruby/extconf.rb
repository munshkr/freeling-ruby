require 'mkmf'

def error(msg)
  message("\nError: #{msg}\n\n")
  abort
end

SWIG_BIN_PATH = ENV['SWIG_BIN_PATH'] || '/usr/bin/swig'

# Check if SWIG_BIN_PATH points to SWIG binary
unless File.exists?(SWIG_BIN_PATH)
  error("#{SWIG_BIN_PATH}: No such file or directory.\n" \
        "Either install SWIG 2.0+, or set SWIG_BIN_PATH to the correct SWIG path.")
end

# Check if it's SWIG 2.0+
ver = `#{SWIG_BIN_PATH} -version`.scan(/Version ([\d.]+)/).flatten.first
unless ver >= '2.0'
  error("#{SWIG_BIN_PATH} version is #{ver}. You need SWIG 2.0.\n" \
        "You can set SWIG_BIN_PATH to the correct SWIG 2.0 path.")
end

unless have_library('db_cxx')
  error("You must have Berkeley DB library (libdb) installed.\n")
end

unless have_library('pcre')
  error("You must have Perl C Regular Expressions library (libpcre) installed.\n")
end

unless have_library('omlet')
  error("You must have libomlet installed.\n")
end

unless have_library('fries')
  error("You must have libfries installed.\n")
end

unless have_library('boost_filesystem')
  error("You must have libboost_filesystem installed.\n")
end

unless have_library('morfo')
  error("You must have libmorfo installed.\n")
end

# SWIG interface filenames
interfaces = Dir.glob(
    File.join(File.dirname(__FILE__), '*.i')
  ).map {|file| File.basename(file, '.i')}

# SWIG Wrapper files should exist before calling create_makefile(),
# so write empty files and delete them so Makefile creates
# the real wrappers. Yuck...
interfaces.each do |file|
  FileUtils.touch(File.join(File.dirname(__FILE__), "#{file}_wrap.cxx"))
end
create_makefile('libmorfo_ruby')
interfaces.each do |file|
  FileUtils.rm_f(File.join(File.dirname(__FILE__), "#{file}_wrap.cxx"))
end

# Append SWIG compilation rules to Makefile
open('Makefile', 'a') do |f|
  f.puts "\nSWIG := #{SWIG_BIN_PATH}\n" \
         "SWIGFLAGS := -c++ -ruby -autorename\n"

  interfaces.each do |file|
    rel_path = File.join(File.dirname(__FILE__), "#{file}.i")
    f.puts "\n#{file}_wrap.cxx: #{rel_path}\n" \
           "\t$(SWIG) $(SWIGFLAGS) -o #{file}_wrap.cxx #{rel_path}\n"
  end
end

require 'mkmf'

def error(msg)
  message(msg + "\n")
  abort
end


default_opt_dirs = ['/usr/local', '/opt/local']
opt_dir = "--with-opt-dir=#{default_opt_dirs.join(':')}"
#ENV['CONFIGURE_ARGS'] = "#{opt_dir} #{ENV['CONFIGURE_ARGS']}"


$libs = append_library($libs, "supc++")


unless have_library('stdc++')
  error('You must have libstdc++ installed.')
end

# TODO write error messages and abort for each of these dependencies
have_library('db_cxx')
have_library('pcre')
have_library('omlet')
have_library('fries')
have_library('boost_filesystem')
have_library('morfo')

#error ':(' unless have_header('freeling.h')


# Run SWIG on each interface file
Dir.glob(File.join(File.dirname(__FILE__), '*.i')).each do |file|
  swig_command = "swig -c++ -ruby #{file}"
  message("running `#{swig_command}`\n")
  system(swig_command)
end

# Finally, create Makefile
create_makefile('freeling')

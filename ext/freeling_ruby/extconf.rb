require 'mkmf'

$LDFLAGS << ' -Wl,-R/usr/local/lib'

def error(msg)
  message("\nError: #{msg}\n\n")
  abort
end

unless have_library('freeling')
  error("You must have `freeling` library installed.\n")
end

create_makefile('freeling_ruby')

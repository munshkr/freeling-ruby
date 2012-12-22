require "mkmf-rice"

%w{ boost_locale freeling }.each do |lib|
  unless have_library(lib)
    message("\nError: You must have `#{lib}` library installed.\n\n")
    abort
  end
end

create_makefile("freeling_ruby")

#include "rice/Class.hpp"

using namespace Rice;

extern "C"
void Init_freeling_ruby() {
  Class rb_cFreelingRuby = define_class("FreelingRuby");
}

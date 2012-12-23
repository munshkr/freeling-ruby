#include "freeling_ruby.h"

Module rb_mFreelingExt;

extern "C"
void Init_freeling_ruby()
{
    RUBY_TRY {
        rb_mFreelingExt = define_module("FreelingExt");

        Init_tokenizer();

        #ifdef TEST
        Init_conversions();
        #endif
    }
    RUBY_CATCH
}

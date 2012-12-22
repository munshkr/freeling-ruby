#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"

#include "wstring.hpp"

//#include "freeling.h"

using namespace Rice;


extern "C"
void Init_freeling_ruby()
{
    RUBY_TRY
    {
        Rice::Module rb_mFreelingExt = define_module("FreelingExt");

        /*
        Data_Type<tokenizer> rb_cTokenizer =
            define_class_under<tokenizer>(rb_mFreelingExt, "Tokenizer")
            .define_constructor(Constructor<tokenizer, std::wstring>())
            ;
        */

        #ifdef TEST
        Rice::Module rb_mWStringTest = define_module("WStringTest");
        rb_mWStringTest
            .define_singleton_method("test_wstring_to_ruby", &test_wstring_to_ruby)
            .define_singleton_method("test_wstring_from_ruby", &test_wstring_from_ruby)
            ;
        #endif // __TEST__
    }
    RUBY_CATCH
}

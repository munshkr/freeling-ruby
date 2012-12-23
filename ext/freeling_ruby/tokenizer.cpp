#include "tokenizer.h"

extern "C"
void Init_tokenizer()
{
    RUBY_TRY
    {
        Data_Type<tokenizer> rb_cTokenizer =
            define_class_under<tokenizer>(rb_mFreelingExt, "Tokenizer");

        rb_cTokenizer
            .define_constructor(Constructor<tokenizer, std::wstring>())
            .define_method("tokenize", tokenize_1(&tokenizer::tokenize))
            ;

    }
    RUBY_CATCH
}

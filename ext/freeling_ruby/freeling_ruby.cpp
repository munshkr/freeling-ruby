#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"

#include "wstring.hpp"

//#include "freeling.h"

using namespace Rice;


std::wstring return_wstring()
{
    std::wstring str = L"Damián";
    return str;
}

void print_wstring(std::wstring str)
{
    std::wcout << str << std::endl;
}


extern "C"
void Init_freeling_ruby() {
  RUBY_TRY {
    Rice::Module rb_mFreelingExt = define_module("FreelingExt");

    rb_mFreelingExt
      .define_singleton_method("return_wstring", &return_wstring)
      .define_singleton_method("print_wstring", &print_wstring)
      ;

    /*
    Data_Type<tokenizer> rb_cTokenizer =
      define_class_under<tokenizer>(rb_mFreelingExt, "Tokenizer")
      .define_constructor(Constructor<tokenizer, std::wstring>())
      ;
    */
  }
  RUBY_CATCH
}

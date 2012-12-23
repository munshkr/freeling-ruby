#include "conversions.h"

using namespace Rice;

// convert an UTF-8 Ruby String into a wstring
template<>
std::wstring from_ruby<std::wstring>(Object o) {
    String rs = (String) o.value();
    std::wstring ws = boost::locale::conv::utf_to_utf<wchar_t>(rs.str());
    return ws;
}

// convert a wstring into an UTF-8 Ruby String
template<>
Object to_ruby<std::wstring>(std::wstring const& wstr)
{
    std::string s = boost::locale::conv::utf_to_utf<char>(wstr);
    VALUE vs = protect(rb_str_new2, s.c_str());
    VALUE s_utf8 = protect(rb_enc_associate, vs, rb_utf8_encoding());
    return String(s_utf8);
}

/*
template<>
Object to_ruby< std::list<word> >(std::list<word> const& list)
{
    Array::iterator it = list.begin();
    Array::iterator end = a.end();
    for (; it != end; ++it)

}

template<>
std::list<word> from_ruby< std::list<word> > (Object o)
{
    std::list<word> v;
    Array a(o);
    Array::iterator it = a.begin();
    Array::iterator end = a.end();
    for (; it != end; ++it)
        v.push_back(&it->to_s().str());
    return v;
}
*/


#ifdef TEST
std::wstring test_wstring_from_ruby(std::wstring str)
{
    return str;
}

std::wstring test_wstring_to_ruby()
{
    return L"おはよう";
}

extern "C"
void Init_conversions()
{
    RUBY_TRY
    {
        Module rb_mWStringTest = define_module("WStringTest");
        rb_mWStringTest
            .define_singleton_method("test_wstring_to_ruby", &test_wstring_to_ruby)
            .define_singleton_method("test_wstring_from_ruby", &test_wstring_from_ruby)
            ;
    }
    RUBY_CATCH
}
#endif // TEST

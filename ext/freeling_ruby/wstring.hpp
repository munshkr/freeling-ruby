#ifndef __WSTRING_HPP__
#define __WSTRING_HPP__

#include <string>
#include <boost/locale.hpp>
#include "ruby.h"
#include "ruby/encoding.h"

//
// convert an UTF-8 Ruby String into a wstring
//
template<>
std::wstring from_ruby<std::wstring>(Rice::Object o) {
  Rice::String rs = (Rice::String) o.value();
  std::wstring ws = boost::locale::conv::utf_to_utf<wchar_t>(rs.str());
  return ws;
}

//
// convert a wstring into an UTF-8 Ruby String
//
template<>
Rice::Object to_ruby<std::wstring>(std::wstring const& wstr)
{
    std::string s = boost::locale::conv::utf_to_utf<char>(wstr);
    VALUE vs = Rice::protect(rb_str_new2, s.c_str());
    VALUE s_utf8 = Rice::protect(rb_enc_associate, vs, rb_utf8_encoding());
    return Rice::String(s_utf8);
}

#ifdef TEST
std::wstring test_wstring_from_ruby(std::wstring str)
{
    return str;
}

std::wstring test_wstring_to_ruby()
{
    return L"おはよう";
}
#endif // TEST

#endif // __WSTRING_HPP__

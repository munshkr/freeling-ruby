#ifndef __TOKENIZER_H__
#define __TOKENIZER_H__

#include "conversions.h"

#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"

#include "freeling.h"

typedef std::list<word> (tokenizer::*tokenize_1)(const std::wstring &);
typedef std::list<word> (tokenizer::*tokenize_2)(const std::wstring &, unsigned long &);

using namespace Rice;

extern "C" void Init_tokenizer();
extern Module rb_mFreelingExt;

#endif // __TOKENIZER_H__

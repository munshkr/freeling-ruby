#ifndef __ANALYSIS_H__
#define __ANALYSIS_H__

#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"

#endif // __ANALYSIS_H__

/*
class analysis {
   public:
      /// user-managed data, we just store it.
      std::vector<std::wstring> user;

      /// constructor
      analysis();
      /// constructor
      analysis(const std::wstring &, const std::wstring &);
      /// assignment
      analysis& operator=(const analysis&);
      ~analysis();

      void set_lemma(const std::wstring &);
      void set_tag(const std::wstring &);
      void set_prob(double);
      void set_distance(double);
      void set_retokenizable(const std::list<word> &);

      bool has_prob() const;
      bool has_distance() const;
      std::wstring get_lemma() const;
      std::wstring get_tag() const;
      std::wstring get_short_tag() const;
      std::wstring get_short_tag(const std::wstring &) const;
      double get_prob() const;
      double get_distance() const;
      bool is_retokenizable() const;
      std::list<word> get_retokenizable() const;

      std::list<std::pair<std::wstring,double> > get_senses() const;
      void set_senses(const std::list<std::pair<std::wstring,double> > &);
      // useful for java API
      std::wstring get_senses_string() const;

      /// Comparison to sort analysis by *decreasing* probability
      bool operator<(const analysis &) const;
      /// Comparison (to please MSVC)
      bool operator==(const analysis &) const;

      // find out whether the analysis is selected in the tagger k-th best sequence
      bool is_selected(int k=0) const;
      // mark this analysis as selected in k-th best sequence
      void mark_selected(int k=0);
      // unmark this analysis as selected in k-th best sequence
      void unmark_selected(int k=0);
};
*/

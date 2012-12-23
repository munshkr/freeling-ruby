#ifndef __WORD_H__
#define __WORD_H__

#endif // __WORD_H__

/*
////////////////////////////////////////////////////////////////
///   Class word stores all info related to a word:
///  form, list of analysis, list of tokens (if multiword).
////////////////////////////////////////////////////////////////

class word : public std::list<analysis> {
   public:
      /// user-managed data, we just store it.
      std::vector<std::wstring> user;

      /// constructor
      word();
      /// constructor
      word(const std::wstring &);
      /// constructor
      word(const std::wstring &, const std::list<word> &);
      /// constructor
      word(const std::wstring &, const std::list<analysis> &, const std::list<word> &);
      /// Copy constructor
      word(const word &);
      /// assignment
      word& operator=(const word&);

      ~word();

      /// copy analysis from another word
      void copy_analysis(const word &);
      /// Get the number of selected analysis
      int get_n_selected() const;
      /// get the number of unselected analysis
      int get_n_unselected() const;
      /// true iff the word is a multiword compound
      bool is_multiword() const;
      /// get number of words in compound
      int get_n_words_mw() const;
      /// get word objects that compound the multiword
      std::list<word> get_words_mw() const;
      /// get word form
      std::wstring get_form() const;
      /// Get word form, lowercased.
      std::wstring get_lc_form() const;
      /// Get an iterator to the first selected analysis
      word::iterator selected_begin(int k=0);
      /// Get an iterator to the end of selected analysis list
      word::iterator selected_end(int k=0);
      /// Get an iterator to the first unselected analysis
      word::iterator unselected_begin(int k=0);
      /// Get an iterator to the end of unselected analysis list
      word::iterator unselected_end(int k=0);

      #ifndef FL_API_JAVA
      /// Get an iterator to the first selected analysis
      word::const_iterator selected_begin(int k=0) const;
      /// Get an iterator to the end of selected analysis list
      word::const_iterator selected_end(int k=0) const;
      /// Get an iterator to the first unselected analysis
      word::const_iterator unselected_begin(int k=0) const;
      /// Get an iterator to the end of unselected analysis list
      word::const_iterator unselected_end(int k=0) const;
      #endif

      /// get lemma for the selected analysis in list
      std::wstring get_lemma(int k=0) const;
      /// get tag for the selected analysis
      std::wstring get_tag(int k=0) const;
      /// get tag (short version) for the selected analysis, assuming eagles tagset
      std::wstring get_short_tag(int k=0) const;
      /// get tag (short version) for the selected analysis
      std::wstring get_short_tag(const std::wstring &,int k=0) const;

      /// get sense list for the selected analysis
      std::list<std::pair<std::wstring,double> > get_senses(int k=0) const;
      // useful for java API
      std::wstring get_senses_string(int k=0) const;
      /// set sense list for the selected analysis
      void set_senses(const std::list<std::pair<std::wstring,double> > &,int k=0);

      /// get token span.
      unsigned long get_span_start() const;
      unsigned long get_span_finish() const;

      /// get in_dict
      bool found_in_dict() const;
      /// set in_dict
      void set_found_in_dict(bool);
      /// check if there is any retokenizable analysis
      bool has_retokenizable() const;
      /// mark word as having definitive analysis
      void lock_analysis();
      /// check if word is marked as having definitive analysis
      bool is_locked() const;

      /// add an alternative to the alternatives list
      void add_alternative(const word &, double);
      /// replace alternatives list with list given
      void set_alternatives(const std::list<std::pair<word,double> > &);
      /// find out if the speller checked alternatives
      bool has_alternatives() const;
      /// get alternatives list
      std::list<std::pair<word,double> > get_alternatives() const;
      /// get alternatives begin iterator
      std::list<std::pair<word,double> >::iterator alternatives_begin();
      /// get alternatives end iterator
      std::list<std::pair<word,double> >::iterator alternatives_end();

      /// add one analysis to current analysis list  (no duplicate check!)
      void add_analysis(const analysis &);
      /// set analysis list to one single analysis, overwriting current values
      void set_analysis(const analysis &);
      /// set analysis list, overwriting current values
      void set_analysis(const std::list<analysis> &);
      /// set word form
      void set_form(const std::wstring &);
      /// set token span
      void set_span(unsigned long, unsigned long);

      /// look for an analysis with a tag matching given regexp
      bool find_tag_match(boost::u32regex &);

      /// get number of analysis in current list
      int get_n_analysis() const;
      /// empty the list of selected analysis
      void unselect_all_analysis(int k=0);
      /// mark all analysisi as selected
      void select_all_analysis(int k=0);
      /// add the given analysis to selected list.
      void select_analysis(word::iterator, int k=0);
      /// remove the given analysis from selected list.
      void unselect_analysis(word::iterator, int k=0);
      /// get list of analysis (useful for perl API)
      std::list<analysis> get_analysis() const;
      /// get begin iterator to analysis list (useful for perl/java API)
      word::iterator analysis_begin();
      /// get end iterator to analysis list (useful for perl/java API)
      word::iterator analysis_end();
      #ifndef FL_API_JAVA
      /// get begin iterator to analysis list (useful for perl/java API)
      word::const_iterator analysis_begin() const;
      /// get end iterator to analysis list (useful for perl/java API)
      word::const_iterator analysis_end() const;
      #endif
};
*/

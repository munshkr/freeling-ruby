////////////////////////////////////////////////////////////////
//
//  freeling.i
//  This is the SWIG input file, used to generate java/perl/python APIs.
//
////////////////////////////////////////////////////////////////


%include std_list.i
%include std_vector.i
%include std_map.i
%include std_pair.i

%template(VectorWord) std::vector<word>;
%template(ListWord) std::list<word>;
%template(ListAnalysis) std::list<analysis>;
%template(ListSentence) std::list<sentence>;
%template(ListParagraph) std::list<paragraph>;

%template(ListString) std::list<std::wstring>;
%template(ListInt) std::list<int>;
%template(VectorListInt) std::vector<std::list<int> >;
%template(VectorListString) std::vector<std::list<std::wstring> >;
%template(VectorString) std::vector<std::wstring>;

%template(PairDoubleString) std::pair<double,std::wstring >;
%template(VectorPairDoubleString) std::vector<std::pair<double,std::wstring> >;

#ifdef FL_API_PYTHON
%include std_set.i
%template(SetString) std::set<std::wstring>;
#endif

%rename(operator_assignment) operator=;

///////////////  FREELING LANGUAGE DATA CLASSES /////////////

// predeclarations
template <class T> class tree;

template <class T> class generic_iterator;
template <class T> class preorder_iterator;
template <class T> class sibling_iterator;

template <class T> class generic_const_iterator;
template <class T> class const_preorder_iterator;
template <class T> class const_sibling_iterator;

/// Generic iterator, to derive all the others
template<class T, class N>
class tree_iterator {
 protected:
  N *pnode;
 public: 
  tree_iterator();
  tree_iterator(tree<T> *);
  tree_iterator(const tree_iterator<T,N> &);
  ~tree_iterator();

  const tree<T>& operator*() const;
  const tree<T>* operator->() const;
  bool operator==(const tree_iterator<T,N> &) const;
  bool operator!=(const tree_iterator<T,N> &) const;
};

template<class T>
class generic_iterator : public tree_iterator<T,tree<T> > {
 friend class generic_const_iterator<T>;
 public:
  generic_iterator();
  generic_iterator(tree<T> *);
  generic_iterator(const generic_iterator<T> &);
  tree<T>& operator*() const;
  tree<T>* operator->() const;
  ~generic_iterator();
};

/// sibling iterator: traverse all children of the same node

template<class T>
class sibling_iterator : public generic_iterator<T> {
 public:
  sibling_iterator();
  sibling_iterator(const sibling_iterator<T> &);
  sibling_iterator(tree<T> *);
  ~sibling_iterator();

  #ifndef FL_API_PYTHON
  sibling_iterator& operator++();
  sibling_iterator& operator--();
  sibling_iterator operator++(int);
  sibling_iterator operator--(int);
  #endif
};

/// traverse the tree in preorder (parent first, then children)
template<class T>
class preorder_iterator : public generic_iterator<T> {
 public:
  preorder_iterator();
  preorder_iterator(const preorder_iterator<T> &);
  preorder_iterator(tree<T> *);
  preorder_iterator(const sibling_iterator<T> &);
  ~preorder_iterator();

  #ifndef FL_API_PYTHON
  preorder_iterator& operator++();
  preorder_iterator& operator--();
  preorder_iterator operator++(int);
  preorder_iterator operator--(int);
  #endif
};

#ifndef FL_API_JAVA
template<class T>
class generic_const_iterator : public tree_iterator<T,const tree<T> >  {
 public:
  generic_const_iterator();
  generic_const_iterator(const generic_iterator<T> &);
  generic_const_iterator(const generic_const_iterator<T> &);
  generic_const_iterator(const tree<T> *);
  ~generic_const_iterator();
};

template<class T>
class const_sibling_iterator : public generic_const_iterator<T> {
 public:
  const_sibling_iterator();
  const_sibling_iterator(const const_sibling_iterator<T> &);
  const_sibling_iterator(const sibling_iterator<T> &);
  const_sibling_iterator(tree<T> *);
  ~const_sibling_iterator();

  #ifndef FL_API_PYTHON
  const_sibling_iterator& operator++();
  const_sibling_iterator& operator--();
  const_sibling_iterator operator++(int);
  const_sibling_iterator operator--(int);
  #endif
};

template<class T>
class const_preorder_iterator : public generic_const_iterator<T> {
 public:
  const_preorder_iterator();
  const_preorder_iterator(tree<T> *);
  const_preorder_iterator(const const_preorder_iterator<T> &);
  const_preorder_iterator(const preorder_iterator<T> &);
  const_preorder_iterator(const const_sibling_iterator<T> &);
  const_preorder_iterator(const sibling_iterator<T> &);
  ~const_preorder_iterator();
  
  #ifndef FL_API_PYTHON
  const_preorder_iterator& operator++();
  const_preorder_iterator& operator--();
  const_preorder_iterator operator++(int);
  const_preorder_iterator operator--(int);
  #endif
};
#endif

template <class T> 
class tree { 
  friend class preorder_iterator<T>;
  friend class sibling_iterator<T>;

  #ifndef FL_API_JAVA
  friend class const_preorder_iterator<T>;
  friend class const_sibling_iterator<T>;
  #endif

 public:
  T info;
  typedef class preorder_iterator<T> preorder_iterator;
  typedef class sibling_iterator<T> sibling_iterator;
  typedef preorder_iterator iterator;
  #ifndef FL_API_JAVA
  typedef class const_preorder_iterator<T> const_preorder_iterator;
  typedef class const_sibling_iterator<T> const_sibling_iterator;
  typedef const_preorder_iterator const_iterator;
  #endif

  tree();
  tree(const T&);
  tree(const tree<T>&);
  tree(const typename tree<T>::preorder_iterator&);
  ~tree();
  tree<T>& operator=(const tree<T>&);

  unsigned int num_children() const;
  sibling_iterator nth_child(unsigned int) const;
  iterator get_parent() const;
  tree<T> & nth_child_ref(unsigned int) const;
  T& get_info();
  void append_child(const tree<T> &);
  void hang_child(tree<T> &, bool=true);
  void clear();
  bool empty() const;

  sibling_iterator sibling_begin();
  sibling_iterator sibling_end();
  sibling_iterator sibling_rbegin();
  sibling_iterator sibling_rend();
  preorder_iterator begin();
  preorder_iterator end();

  #ifndef FL_API_JAVA
  const_sibling_iterator sibling_begin() const;
  const_sibling_iterator sibling_end() const;
  const_sibling_iterator sibling_rbegin() const;
  const_sibling_iterator sibling_rend() const;
  const_preorder_iterator begin() const;
  const_preorder_iterator end() const;
  #endif
};
 

%template(TreeIteratorNode) tree_iterator<node,tree<node> >;
%template(GenericIteratorNode) generic_iterator<node>;
%template(PreorderIteratorNode) preorder_iterator<node>;
%template(SiblingIteratorNode) sibling_iterator<node>;

%template(TreeIteratorDepnode) tree_iterator<depnode,tree<depnode> >;
%template(GenericIteratorDepnode) generic_iterator<depnode>;
%template(PreorderIteratorDepnode) preorder_iterator<depnode>;
%template(SiblingIteratorDepnode) sibling_iterator<depnode>;

#ifndef FL_API_JAVA
%template(TreeIteratorNodeConst) tree_iterator<node,tree<node> const>;
%template(GenericConstIteratorNode) generic_const_iterator<node>;
%template(ConstPreorderIteratorNode) const_preorder_iterator<node>;
%template(ConstSiblingIteratorNode) const_sibling_iterator<node>;

%template(TreeIteratorDepnodeConst) tree_iterator<depnode,tree<depnode> const>;
%template(GenericConstIteratorDepnode) generic_const_iterator<depnode>;
%template(ConstPreorderIteratorDepnode) const_preorder_iterator<depnode>;
%template(ConstSiblingIteratorDepnode) const_sibling_iterator<depnode>;
#endif

%template(TreeNode) tree<node>;
%template(TreeDepnode) tree<depnode>;


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

////////////////////////////////////////////////////////////////
///   Class parse tree is used to store the results of parsing
///  Each node in the tree is either a label (intermediate node)
///  or a word (leaf node)
////////////////////////////////////////////////////////////////

class node {
  public:
    /// constructors
    node();
    node(const std::wstring &);
    ~node();

    /// get node identifier
    std::wstring get_node_id() const;
    /// set node identifier
    void set_node_id(const std::wstring &);
    /// get node label
    std::wstring get_label() const;
    /// get node word
    word get_word() const;
    /// set node label
    void set_label(const std::wstring &);
    /// set node word
    void set_word(word &);
    /// find out whether node is a head
    bool is_head() const;
    /// set whether node is a head
    void set_head(const bool);
    /// find out whether node is a chunk
    bool is_chunk() const;
    /// set position of the chunk in the sentence
    void set_chunk(const int);
    /// get position of the chunk in the sentence
    int  get_chunk_ord() const;
};

class parse_tree : public tree<node> {
  public:
    parse_tree();
    parse_tree(const node &);
};


////////////////////////////////////////////////////////////////
/// class denode stores nodes of a dependency tree and
///  parse tree <-> deptree relations
////////////////////////////////////////////////////////////////

class depnode : public node {
  public:
    depnode();
    depnode(const std::wstring &);
    depnode(const node &);
    ~depnode();

    void set_link(const parse_tree::iterator);
    parse_tree::iterator get_link(void);
    tree<node>& get_link_ref(void);
    void set_label(const std::wstring &);
};

////////////////////////////////////////////////////////////////
/// class dep_tree stores a dependency tree
////////////////////////////////////////////////////////////////

class dep_tree :  public tree<depnode> {
  public:
    dep_tree();
    dep_tree(const depnode &);
};


////////////////////////////////////////////////////////////////
///   Class sentence is just a list of words that someone
/// (the splitter) has validated it as a complete sentence.
/// It may include a parse tree.
////////////////////////////////////////////////////////////////

class sentence : public std::list<word> {
 public:
  sentence();
  sentence(const std::list<word>&);
  /// Copy constructor
  sentence(const sentence &);
  /// assignment
  sentence& operator=(const sentence&);

  ~sentence();

  /// find out how many kbest sequences the tagger computed
  unsigned int num_kbest() const;

  void set_parse_tree(const parse_tree &);
  parse_tree & get_parse_tree(void);
  bool is_parsed() const;  

  dep_tree & get_dep_tree();
  void set_dep_tree(const dep_tree &);
  bool is_dep_parsed() const;

  /// get word list (useful for perl API)
  std::vector<word> get_words() const;
  /// get iterators to word list (useful for perl/java API)
  sentence::iterator words_begin(void);
  sentence::iterator words_end(void);

  #ifndef FL_API_JAVA
  sentence::const_iterator words_begin(void) const;
  sentence::const_iterator words_end(void) const;
  #endif
};

////////////////////////////////////////////////////////////////
///   Class paragraph is just a list of sentences that someone
///  has validated it as a paragraph.
////////////////////////////////////////////////////////////////

class paragraph : public std::list<sentence> {};

////////////////////////////////////////////////////////////////
///   Class document is a list of paragraphs. It may have additional 
///  information (such as title)
////////////////////////////////////////////////////////////////

class document : public std::list<paragraph> {
 public:
    document();
    ~document();

    void add_positive(std::wstring, std::wstring);
    int get_coref_group(std::wstring) const;
    std::list<std::wstring> get_coref_nodes(int) const;
    bool is_coref(std::wstring, std::wstring) const;
};



////////////////  FREELING ANALYSIS MODULES  ///////////////////


/*------------------------------------------------------------------------*/
class traces {
 public:
    // current trace level
    static int TraceLevel;
    // modules to trace
    static unsigned long TraceModule;
};


/*------------------------------------------------------------------------*/
class lang_ident {
   public:
      /// constructor
      lang_ident (const std::wstring &);
      ~lang_ident();

      /// Identify language, return most likely language for given text
      std::wstring identify_language(const std::wstring &, const std::set<std::wstring> &) const;
      /// Identify language, return list of pairs<probability,language> 
      /// sorted by decreasing probability.
      void rank_languages(std::vector<std::pair<double,std::wstring> > &, 
			  const std::wstring &, 
			  const std::set<std::wstring> &) const;
};


/*------------------------------------------------------------------------*/
class tokenizer {
   public:
       /// Constructor
       tokenizer(const std::wstring &);
       ~tokenizer();

       /// tokenize wstring with default options
       std::list<word> tokenize(const std::wstring &);
       /// tokenize wstring with default options, tracking offset in given int param.
       std::list<word> tokenize(const std::wstring &, unsigned long &);
};

/*------------------------------------------------------------------------*/
class splitter {
   public:
      /// Constructor
      splitter(const std::wstring &);
      ~splitter();

      /// split sentences with default options
      std::list<sentence> split(const std::list<word> &, bool);
};


/*------------------------------------------------------------------------*/
class maco_options {
 public:
    // Language analyzed
    std::wstring Lang;

    /// Morhpological analyzer active modules.
    bool AffixAnalysis,   MultiwordsDetection, 
         NumbersDetection, PunctuationDetection, 
         DatesDetection,   QuantitiesDetection, 
         DictionarySearch, ProbabilityAssignment,
         OrthographicCorrection, UserMap;
    int NERecognition;

    /// Morphological analyzer modules configuration/data files.
    std::wstring LocutionsFile, QuantitiesFile, AffixFile, 
           ProbabilityFile, DictionaryFile, 
           NPdataFile, PunctuationFile,
           CorrectorFile, UserMapFile;

    /// module-specific parameters for number recognition
    std::wstring Decimal, Thousand;
    /// module-specific parameters for probabilities
    double ProbabilityThreshold;
    /// module-specific parameters for dictionary
    bool InverseDict,RetokContractions;

    /// constructor
    maco_options(const std::wstring &);
    ~maco_options();

    /// Option setting methods provided to ease perl interface generation. 
    /// Since option data members are public and can be accessed directly
    /// from C++, the following methods are not necessary, but may become
    /// convenient sometimes.
    void set_active_modules(bool,bool,bool,bool,bool,bool,bool,bool,bool,bool,bool);
    void set_data_files(const std::wstring &,const std::wstring &,const std::wstring &,
                        const std::wstring &,const std::wstring &,const std::wstring &,
                        const std::wstring &,const std::wstring &, const std::wstring &);

    void set_nummerical_points(const std::wstring &,const std::wstring &);
    void set_threshold(double);
    void set_inverse_dict(bool);
    void set_retok_contractions(bool);
};

/*------------------------------------------------------------------------*/
class maco {
   public:
      /// Constructor
      maco(const maco_options &);
      ~maco();

      #ifndef FL_API_JAVA
      /// analyze sentence
      sentence analyze(const sentence &);
      /// analyze sentences
      std::list<sentence> analyze(const std::list<sentence> &);
      #else
      /// analyze sentence
      void analyze(sentence &);
      /// analyze sentences
      void analyze(std::list<sentence> &);
      #endif
};


/*------------------------------------------------------------------------*/
class RE_map {
    
 public:
  /// Constructor (config file)
  RE_map(const std::wstring &); 
  ~RE_map();
 
  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class numbers {
  public:
    // constructor: language (en), decimal (.), thousands (,)
    numbers(const std::wstring &, const std::wstring &, const std::wstring &);
    ~numbers();

    #ifndef FL_API_JAVA
    /// analyze sentence
    sentence analyze(const sentence &);
    /// analyze sentences
    std::list<sentence> analyze(const std::list<sentence> &);
    #else
    /// analyze sentence
    void analyze(sentence &);
    /// analyze sentences
    void analyze(std::list<sentence> &);
    #endif
};


/*------------------------------------------------------------------------*/
class punts {
 public:
  /// Constructor (config file)
  punts(const std::wstring &); 
  ~punts();

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/ 
class dates {
 public:   
  /// Constructor (config file)
  dates(const std::wstring &); 
  /// Destructor
  ~dates(); 

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};  

/*------------------------------------------------------------------------*/
class dictionary {
 public:
  /// Constructor
  dictionary(const std::wstring &, const std::wstring &, bool, const std::wstring &, bool invDic=false, bool retok=true);
  /// Destructor
  ~dictionary();

  /// Get dictionary entry for a given form, add to given list.
  void search_form(const std::wstring &, std::list<analysis> &);
  /// Fills the analysis list of a word, checking for suffixes and contractions.
  /// Returns true iff the form is a contraction.
  bool annotate_word(word &, std::list<word> &);
  /// Get possible forms for a lemma+pos
  std::list<std::wstring> get_forms(const std::wstring &, const std::wstring &) const;

  #ifndef FL_API_JAVA
  /// analyze sentence, return analyzed copy
  sentence analyze(const sentence &);
  /// analyze sentences, return analyzed copy
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze given sentence
  void analyze(sentence &);
  /// analyze given sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class locutions {
 public:
  /// Constructor (config file)
  locutions(const std::wstring &);
  ~locutions();
  void add_locution(const std::wstring &);

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class ner {
 public:
  /// Constructor (config file)
  ner(const std::wstring &);
  /// Destructor
  ~ner();

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class quantities {
 public:
  /// Constructor (language, config file)
  quantities(const std::wstring &, const std::wstring &); 
  /// Destructor
  ~quantities(); 

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class probabilities {
 public:
  /// Constructor (language, config file, threshold)
  probabilities(const std::wstring &, const std::wstring &, double);
  ~probabilities();

  /// Assign probabilities for each analysis of given word
  void annotate_word(word &);
  /// Turn guesser on/of
  void set_activate_guesser(bool);

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class hmm_tagger {
 public:
  /// Constructor
  hmm_tagger(const std::wstring &, const std::wstring &, bool, unsigned int, unsigned int kb=1);
  ~hmm_tagger();
  
  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};


/*------------------------------------------------------------------------*/
class relax_tagger {
 public:
  /// Constructor, given the constraints file and config parameters
  relax_tagger(const std::wstring &, int, double, double, bool, unsigned int);
  ~relax_tagger();

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class phonetics {  
 public:
  /// Constructor, given config file
  phonetics(const std::wstring&);
  ~phonetics();
  
  /// Returns the phonetic sound of the word
  std::wstring get_sound(const std::wstring &);

  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};

/*------------------------------------------------------------------------*/
class nec {
 public:
  /// Constructor
  nec(const std::wstring &); 
  /// Destructor
  ~nec();
  
  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};


/*------------------------------------------------------------------------*/
class chart_parser {
 public:
   /// Constructors
   chart_parser(const std::wstring&);
   ~char_parser();

   /// Get the start symbol of the grammar
   std::wstring get_start_symbol(void) const;

   #ifndef FL_API_JAVA
   /// analyze sentence
   sentence analyze(const sentence &);
   /// analyze sentences
   std::list<sentence> analyze(const std::list<sentence> &);
   #else
   /// analyze sentence
   void analyze(sentence &);
   /// analyze sentences
   void analyze(std::list<sentence> &);
   #endif
};


/*------------------------------------------------------------------------*/
class dep_txala {
 public:   
   dep_txala(const std::wstring &, const std::wstring &);
   ~dep_txala();

   #ifndef FL_API_JAVA
   /// analyze sentence
   sentence analyze(const sentence &);
   /// analyze sentences
   std::list<sentence> analyze(const std::list<sentence> &);
   #else
   /// analyze sentence
   void analyze(sentence &);
   /// analyze sentences, return analyzed copy
   void analyze(std::list<sentence> &);
   #endif
};



/*------------------------------------------------------------------------*/
class senses {
 public:
  /// Constructor
  senses(const std::wstring &); 
  /// Destructor
  ~senses(); 
  
  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};


/*------------------------------------------------------------------------*/
class ukb_wrap {
 public:
  /// Constructor
  ukb_wrap(const std::wstring &);
  /// Destructor
  ~ukb_wrap();
  
  #ifndef FL_API_JAVA
  /// analyze sentence
  sentence analyze(const sentence &);
  /// analyze sentences
  std::list<sentence> analyze(const std::list<sentence> &);
  #else
  /// analyze sentence
  void analyze(sentence &);
  /// analyze sentences
  void analyze(std::list<sentence> &);
  #endif
};


/*------------------------------------------------------------------------*/
class sense_info {
 public:
  /// sense code
  std::wstring sense;
  /// hyperonyms
  std::list<std::wstring> parents;
  /// WN semantic file code
  std::wstring semfile;
  /// list of synonyms (words in the synset)
  std::list<std::wstring> words;
  /// list of EWN top ontology properties
  std::list<std::wstring> tonto;

  /// constructor
  sense_info(const std::wstring &,const std::wstring &);
  std::wstring get_parents_string() const;
};


////////////////////////////////////////////////////////////////
/// Class semanticDB implements a semantic DB interface
////////////////////////////////////////////////////////////////

class semanticDB {
 public:
  /// Constructor
  semanticDB(const std::wstring &);
  /// Destructor
  ~semanticDB();
  
  /// Compute list of lemma-pos to search in WN for given word, according to mapping rules.
  void get_WN_keys(const std::wstring &, const std::wstring &, const std::wstring &, std::list<std::pair<std::wstring,std::wstring> > &) const;
  /// get list of words for a sense
  std::list<std::wstring> get_sense_words(const std::wstring &) const;
  /// get list of senses for a lemma+pos
  std::list<std::wstring> get_word_senses(const std::wstring &, const std::wstring &, const std::wstring &) const;
  /// get sense info for a sense
  sense_info get_sense_info(const std::wstring &) const;
};

class util {
 public:
  /// Init the locale of the program, to properly handle unicode
  static void init_locale(const std::wstring &);

  /// conversion utilities
  static int wstring2int(const std::wstring &);
  static std::wstring int2wstring(const int);
  static double wstring2double(const std::wstring &);
  static std::wstring double2wstring(const double);
  static long double wstring2longdouble(const std::wstring &);
  static std::wstring longdouble2wstring(const long double);
  static std::wstring vector2wstring(const std::vector<std::wstring> &, const std::wstring &);
  static std::wstring list2wstring(const std::list<std::wstring> &, const std::wstring &);
  static std::wstring pairlist2wstring(const std::list<std::pair<std::wstring, double> > &, const std::wstring &, const std::wstring &);
  static std::list<std::wstring> wstring2list(const std::wstring &, const std::wstring &);
  static std::vector<std::wstring> wstring2vector(const std::wstring &, const std::wstring &);
};

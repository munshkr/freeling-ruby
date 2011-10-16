Ruby bindings for FreeLing
==========================

Usage
-----

...

Requirements
------------

  * FreeLing 2.2.2
  * libfries 1.2.1
  * libomlet 1.0.1

Install
-------

### FreeLing 2.2 ###

Be sure to read Chapter 2 of the [user
manual](http://nlp.lsi.upc.edu/freeling/doc/userman/userman.pdf) on how to
compile and install the toolkit. There are also Debian packages for some
versions of Ubuntu, but I haven't tested them myself.

[Download FreeLing](http://devel.cpl.upc.edu/freeling/downloads?order=time&desc=1)

#### `property_map.hpp` compile error ####

If you happen to come across the following compile error

    In file included from disambiguator/disambiguator.cc:32:0:
    disambiguator/ukb/common.h:23:34: fatal error: boost/property_map.hpp: No such file or directory
    compilation terminated.

you may need to apply [this patch](http://devel.cpl.upc.edu/freeling/changeset/736?format=diff&new=736):

    $ patch -p3 < changeset_r736.diff

### Ruby bindings ###

*NOTE: Gem has not been uploaded yet because it's still in early alpha stages. You'll have to clone this repo and install the gem with `rake install`*

    # gem install freeling-ruby

Legal
-----

...

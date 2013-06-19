custom_termini_examples
=======================

Example use from command line:

export RUBYLIB=$RUBYLIB:<path to this git repo>/lib_
puppet master --no-daemonize --debug --facts_terminus custom_fact_terminus --catalog_terminus custom_catalog_terminus

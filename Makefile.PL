use inc::Module::Install;
name 'DBIx-Skinny-Cache';
all_from 'lib/DBIx/Skinny/Cache.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

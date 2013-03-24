#!perl -w
use strict;
use Test::More tests => 1;

BEGIN {
    use_ok 'Redisism';
    use_ok 'Redisism::Base';
    use_ok 'Redisism::List';
    use_ok 'Redisism::Set';
    use_ok 'Redisism::SortedSet';
}

diag "Testing Redisism/$Redisism::VERSION";

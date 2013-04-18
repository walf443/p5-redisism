package  t::Redisism::TestInt;
use strict;
use warnings;
use parent qw(Redisism::Int);

package main;
use strict;
use warnings;
use Test::More;
use t::Util;

my $server = t::Util->start_redis_server;
my $redis = t::Util->get_redis_client_for($server);

my $test_int = t::Redisism::TestInt->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_int->generate_key(id => 1), "t::Redisism::TestInt:id:1", "generate_key ok");
    };

    subtest "incr" => sub {
        is($test_int->incr(id => 1), 1, "incr OK");
    };

    subtest "decr" => sub {
        is($test_int->decr(id => 1), 0, "decr OK");
    };

    subtest "incrby" => sub {
        is($test_int->incrby(2, id => 1), 2, "incrby OK");
    };

    subtest "decrby" => sub {
        is($test_int->decrby(3, id => 1), -1, "decrby OK");
    };

};

done_testing;

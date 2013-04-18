package  t::Redisism::TestFloat;
use strict;
use warnings;
use parent qw(Redisism::Float);

package main;
use strict;
use warnings;
use Test::More;
use t::Util;

my $server = t::Util->start_redis_server;
my $redis = t::Util->get_redis_client_for($server);

my $test_float = t::Redisism::TestFloat->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_float->generate_key(id => 1), "t::Redisism::TestFloat:id:1", "generate_key ok");
    };

    subtest "incrbyfloat" => sub {
        is($test_float->incrbyfloat(0.1, id => 1), 0.1, "incrbyfloat OK");
        is($test_float->incrby(0.1, id => 1), 0.2, "incrby OK");
    };

};

done_testing;

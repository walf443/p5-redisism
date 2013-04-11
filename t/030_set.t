package t::Redisism::TestSet;
use strict;
use warnings;
use parent qw(Redisism::Set);

package main;
use strict;
use warnings;
use Test::More;
use t::Util;

my $server = t::Util->start_redis_server;
my $redis = t::Util->get_redis_client_for($server);
my $test_set = t::Redisism::TestSet->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_set->generate_key(id => 1), "t::Redisism::TestSet:id:1", "generate_key ok");
    };

    subtest "sadd" => sub {
        is($test_set->sadd("test:1", id => 1), 1, "sadd OK");
        is($test_set->add("test:2", id => 1), 1, "add OK");
        is($test_set->add(["test:1", "test:2", "test:3", "test:4"], id => 1), 2, "multi item with duplicate OK");
    };

    subtest "scard" => sub {
        is($test_set->scard(id => 1), 4, "scard OK");
        is($test_set->length(id => 1), 4, "length OK");
    };

    subtest "sdiff" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "sdiffstore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "sinter" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "sinterstore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "sismember" => sub {
        is($test_set->sismember("test:1", id => 1), 1, "sismember OK");
        is($test_set->sismember("test:0", id => 1), 0, "sismember OK");
    };
    subtest "smembers" => sub {
        my $result = $test_set->smembers(id => 1);
        is_deeply([sort @{ $result }], [qw(test:1 test:2 test:3 test:4)], "smembers OK");
    };
    subtest "smove" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "spop" => sub {
        my $result = $test_set->spop(id => 1);
        like($result, qr/test:\d/, "spop OK");
        $result = $test_set->pop(id => 1);
        like($result, qr/test:\d/, "pop OK");
        is($test_set->length(id => 1), 2, "member is removed OK");
    };
    subtest "srandmember" => sub {
        my $results = $test_set->srandmember(1, id => 1);
        is(@{$results}, 1, "length OK");
        for my $res ( @$results ) {
            like($res , qr/test:\d/, "srandmember OK");
        }

        $results = $test_set->sample(2, id => 1);
        is(@{$results}, 2, "length OK");
        for my $res ( @$results ) {
            like($res , qr/test:\d/, "sample OK");
        }
        is($test_set->length(id => 1), 2, "member is not removed OK");
    };
    subtest "srem" => sub {
        $test_set->sadd("test:1", id => 1);
        is($test_set->srem("test:1", id => 1), 1, "srem OK");
        $test_set->sadd("test:1", id => 1);
        is($test_set->remove("test:1", id => 1), 1, "remove OK");
    };
    subtest "sunion" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "sunionstore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
};

done_testing;

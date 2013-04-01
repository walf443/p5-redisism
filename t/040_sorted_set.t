package t::Redisism::TestSortedSet;
use strict;
use warnings;
use parent qw(Redisism::SortedSet);

package main;
use strict;
use warnings;
use Test::More;
use Test::RedisServer;
use RedisDB;

my $server;
eval {
    $server = Test::RedisServer->new;
}
    or plan skip_all => 'redis-server is required for this test';

my %conn = $server->connect_info;

my $redis = RedisDB->new(path => $conn{sock});
my $test_zset = t::Redisism::TestSortedSet->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_zset->generate_key(id => 1), "t::Redisism::TestSortedSet:id:1", "generate_key ok");
    };

    subtest "zadd" => sub {
        is($test_zset->zadd(10, "test:1", id => 1), 1, "zadd OK");
        is($test_zset->add(20, "test:2", id => 1), 1, "add OK");
    };

    subtest "zcard" => sub {
        is($test_zset->zcard(id => 1), 2, "zcard OK");
        is($test_zset->length(id => 1), 2, "length OK");
    };

    subtest "zcount" => sub {
        is($test_zset->zcount(11, 21, id => 1), 1, "zcount OK");
    };

    subtest "zincrby" => sub {
        is($test_zset->zincrby(5, "test:1", id => 1), 15, "zincrby OK");
    };
    subtest "zinterstore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrange" => sub {
        is_deeply($test_zset->zrange(0, 1, undef, id => 1), ["test:1", "test:2"], "zrange without score OK");
        is_deeply($test_zset->zrange(0, 1, "withscores", id => 1), ["test:1" => 15, "test:2" => 20], "zrange with score OK");
    };
    subtest "zrevrange" => sub {
        is_deeply($test_zset->zrevrange(0, 2, undef, id => 1), ["test:2", "test:1"], "zrevrange without scores OK");
        is_deeply($test_zset->zrevrange(0, 2, "withscores", id => 1), ["test:2", 20, "test:1", 15], "zrevrange with scores OK");
    };
    subtest 'range' => sub {
        is_deeply($test_zset->range(0, 2, undef, id => 1), ["test:2", "test:1"], "range without scores OK");
        is_deeply($test_zset->range(0, 2, "withscores", id => 1), ["test:2", 20, "test:1", 15], "range with scores OK");
    };
    subtest "zrank" => sub {
        is($test_zset->zrank("test:1", id => 1), 0, "zrank OK");
        is($test_zset->zrank("test:2", id => 1), 1, "zrank OK");
    };
    subtest "zrevrank" => sub {
        is($test_zset->zrevrank("test:1", id => 1), 1, "zzrevrank OK");
        is($test_zset->zrevrank("test:2", id => 1), 0, "zzrevrank OK");
    };
    subtest "rank" => sub {
        is($test_zset->rank("test:1", id => 1), 1, "rank OK");
        is($test_zset->rank("test:2", id => 1), 0, "rank OK");
    };
    subtest "zrevrangebyscore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zscore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrem" => sub {
        is($test_zset->zrem("test:1", id => 1), 1, "zrem OK");
        is($test_zset->remove(["test:1"], id => 1), 0, "zrem OK");
    };
    subtest "zremrangebyrank" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zremrangebyscore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
};

done_testing;

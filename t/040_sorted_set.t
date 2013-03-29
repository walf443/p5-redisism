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
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };

    subtest "zcard" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };

    subtest "zcount" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };

    subtest "zincrby" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zinterstore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrange" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrank" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrem" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
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
    subtest "zrevrange" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrevrangebyscore" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "zrevrank" => sub {
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
};

done_testing;

package t::Redisism::TestSet;
use strict;
use warnings;
use parent qw(Redisism::Set);

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
my $test_set = t::Redisism::TestSet->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_set->generate_key(id => 1), "t::Redisism::TestSet:id:1", "generate_key ok");
    };

    subtest "sadd" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
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
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "smembers" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "smove" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "spop" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "srandmember" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "srem" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
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

package t::Redisism::TestList;
use strict;
use warnings;
use parent qw(Redisism::List);

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
my $test_list = t::Redisism::TestList->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_list->generate_key(id => 1), "t::Redisism::TestList:id:1", "generate_key ok");
    };
    subtest "blpop" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "brpop" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "brpoplpush" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "push" => sub {
        is($test_list->lpush("foo", id => 1), 1, "push ok");
        is($test_list->lpush("bar", id => 1), 2, "push ok");
    };

    subtest "llen" => sub {
        is($test_list->llen(id => 1),   2, "push ok");
        is($test_list->length(id => 1), 2, "push ok");
    };

    subtest "lindex" => sub {
        is($test_list->lindex(0, id => 1), "bar", "index ok");
        is($test_list->lindex(1, id => 1), "foo", "index ok");
    };
    subtest "lrange" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "lset" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "lrem" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "ltrim" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "rpop" => sub {
        is($test_list->rpop(id => 1), "foo", "rpop ok");
        is($test_list->rpop(id => 1), "bar", "rpop ok");
        is($test_list->rpop(id => 1), undef, "rpop ok");
    };
    subtest "lpop" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
};

done_testing;

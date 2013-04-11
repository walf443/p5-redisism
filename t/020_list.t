package t::Redisism::TestList;
use strict;
use warnings;
use parent qw(Redisism::List);

package main;
use strict;
use warnings;
use Test::More;
use t::Util;

my $server = t::Util->start_redis_server;
my $redis = t::Util->get_redis_client_for($server);
my $test_list = t::Redisism::TestList->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_list->generate_key(id => 1), "t::Redisism::TestList:id:1", "generate_key ok");
    };

    subtest "pushx" => sub {
        subtest "without key" => sub {
            is($test_list->lpushx("foo", id => 1), 0, "lpushx ok");
            is($test_list->unshift_if_exists("foo", id => 1), 0, "unshift_if_exists ok");
            is($test_list->rpushx("foo", id => 1), 0, "rpushx ok");
            is($test_list->push_if_exists("foo", id => 1), 0, "push_if_exists ok");
        };
        subtest "with key" => sub {
            $test_list->unshift("foo", id => 1);
            is($test_list->lpushx("foo", id => 1), 2, "lpushx ok");
            is($test_list->unshift_if_exists("foo", id => 1), 3, "unshift_if_exists ok");
            is($test_list->rpushx("foo", id => 1), 4, "rpushx ok");
            is($test_list->push_if_exists("foo", id => 1), 5, "push_if_exists ok");
        };
    };

    subtest "lpush" => sub {
        $test_list->delete(id => 1);
        is($test_list->lpush("foo", id => 1), 1, "lpush ok");
        is($test_list->unshift("bar", id => 1), 2, "unshift ok");
    };

    subtest "llen" => sub {
        is($test_list->llen(id => 1),   2, "length ok");
        is($test_list->length(id => 1), 2, "length ok");
    };

    subtest "lindex" => sub {
        is($test_list->lindex(0, id => 1), "bar", "lindex ok");
        is($test_list->index(1, id => 1), "foo", "index ok");
        is($test_list->lindex(-1, id => 1), "foo", "minus index ok");
        is($test_list->lindex(100, id => 1), undef, "out of range ok");
    };

    subtest "lrange" => sub {
        is_deeply($test_list->lrange(0, 0, id => 1), ["bar"], "lrange ok");
        is_deeply($test_list->range(0, 1, id => 1), ["bar", "foo"], "range ok");
    };

    subtest "lset" => sub {
        is($test_list->lset(1, "baz", id => 1), 'OK', "lset OK");
        is($test_list->set(1, "foo", id => 1), 'OK', "set OK");
    };

    subtest "rpop" => sub {
        is($test_list->rpop(id => 1), "foo", "rpop ok");
        is($test_list->pop(id => 1), "bar", "pop ok");
        is($test_list->rpop(id => 1), undef, "pop without items ok");
    };

    subtest "lpop" => sub {
        $test_list->delete;
        $test_list->push("foo", id => 1);
        $test_list->push("bar", id => 1);
        is($test_list->lpop(id => 1), "foo", "lpop ok");
        is($test_list->shift(id => 1), "bar", "shift ok");
        is($test_list->lpop(id => 1), undef, "shift without items OK");
    };

    subtest "lrem" => sub {
        $test_list->delete;
        $test_list->push("foo", id => 1);
        $test_list->push("bar", id => 1);
        is($test_list->lrem(0, "foo", id => 1), 1, "lrem ok");
        is($test_list->remove(0, "bar", id => 1), 1, "remove ok");
    };

    subtest "ltrim" => sub {
        $test_list->delete;
        $test_list->push("foo", id => 1);
        $test_list->push("bar", id => 1);
        is($test_list->ltrim(0, 0, id => 1), "OK", "lrem ok");
        is($test_list->trim(0, 1, "bar", id => 1), "OK", "trim ok");
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
};

done_testing;

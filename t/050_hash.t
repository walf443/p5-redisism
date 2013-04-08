package t::Redisism::TestHash;
use strict;
use warnings;
use parent qw(Redisism::Hash);

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
my $test_hash = t::Redisism::TestHash->new(
    redis => $redis,
);

subtest "test for id => 1" => sub {
    subtest "generate_key" => sub {
        is($test_hash->generate_key(id => 1), "t::Redisism::TestHash:id:1", "generate_key ok");
    };

    subtest "hset" => sub {
        is($test_hash->hset("field1", "value", id => 1), 1, "added new field OK");
        is($test_hash->hset("field1", "value", id => 1), 0, "update field OK");
        is($test_hash->set_field("field1", "value", id => 1), 0, "update field OK");
    };
    subtest "hsetnx" => sub {
        is($test_hash->hsetnx("field1", "value_by_hashnx", id => 1), 0, "does not update field OK");
        is($test_hash->hget("field1", id => 1), "value", "should not update value");

        is($test_hash->set_field_if_not_exists("field1", "value_by_hashnx", id => 1), 0, "does not field OK");
        is($test_hash->hget("field1", id => 1), "value", "should not update value");

        is($test_hash->set_field_if_not_exists("field2", "value", id => 1), 1, "add new field OK");
        is($test_hash->hget("field2", id => 1), "value", "added new field OK");
    };
    subtest "hmset" => sub {
        TODO: {
            local $TODO = "not implemented";
            fail("not implemented");
        }
    };
    subtest "hget" => sub {
        is($test_hash->hget("field1", id => 1), "value", "hget OK");
        is($test_hash->hget("should_not_exists_field", id => 1), undef, "hget OK");
        is($test_hash->get_field("field1", id => 1), "value", "get_field OK");
    };
    subtest "hexists" => sub {
        is($test_hash->hexists("field1", id => 1), 1, "hexists OK");
        is($test_hash->hexists("should_not_exists_field", id => 1), 0, "hexists OK");
    };
    subtest "hgetall" => sub {
        is_deeply($test_hash->hgetall(id => 1), ["field1", "value", "field2", "value"], "hgetall OK");
    };
    subtest "hkeys" => sub {
        is_deeply($test_hash->hkeys(id => 1), ["field1", "field2"], "hkeys are OK");
        is_deeply($test_hash->keys(id => 1), ["field1", "field2"], "keys are OK");
    };
    subtest "hlen" => sub {
        is($test_hash->hlen(id => 1), 2, "hlen is OK");
        is($test_hash->length(id => 1), 2, "length is OK");
    };
    subtest "hvals" => sub {
        is_deeply($test_hash->hvals(id => 1), ["value", "value"], "hvals are OK");
        is_deeply($test_hash->values(id => 1), ["value", "value"], "values are OK");
    };
    subtest "hincrby" => sub {
        subtest "with none integer field" => sub {
            my $ret;
            eval {
                $ret = $test_hash->hincrby("field1", 1, id => 1);
            };
            is($ret, undef, "It should not return value");
            ok($@, "It should cause error");
        };

        subtest "without field" => sub {
            is($test_hash->hincrby("num_field", 1, id => 1), 1, "key created OK");
        };
    };
    subtest "hincrbyfloat" => sub {
        subtest "with none integer field" => sub {
            my $ret;
            eval {
                $ret = $test_hash->hincrbyfloat("field1", 1, id => 1);
            };
            is($ret, undef, "It should not return value");
            ok($@, "It should cause error");
        };

        subtest "without field" => sub {
            is($test_hash->hincrbyfloat("float_field", 0.1, id => 1), 0.1, "key created OK");
        };
    };
    subtest "hdel" => sub {
        is($test_hash->hdel("field1", id => 1), 1, "hdel is OK");
        is($test_hash->hdel(["num_field", "float_field"], id => 1), 2, "removing multi fields OK");
        is($test_hash->remove_fields("field2", id => 1), 1, "remove_fields OK");
    };
};

done_testing;

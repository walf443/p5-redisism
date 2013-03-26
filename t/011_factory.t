package t::Redisism::TestKey;
use strict;
use warnings;
use parent qw(Redisism::Base);

package main;
use strict;
use warnings;
use Test::More;
use Test::RedisServer;
use RedisDB;
use Redisism::Factory;

my $server;
eval {
    $server = Test::RedisServer->new;
}
    or plan skip_all => 'redis-server is required for this test';

my %conn = $server->connect_info;

my $redis = RedisDB->new(path => $conn{sock});

subtest "with namespace" => sub {
    my $factory = Redisism::Factory->new(
        redis => $redis,
        namespace => 't::Redisism',
    );

    subtest 'it should be able to get package under namespace' => sub {
        my $created_item = $factory->create("TestKey");
        isa_ok($created_item, "t::Redisism::TestKey");
        is($created_item->redis, $redis, "redis connection should be equal");
        is(!!$created_item->server_info->{redis_version}, 1, "redis_version OK");
    };

    subtest 'it should be able to get package with full namespace' => sub {
        my $created_item = $factory->create("+t::Redisism::TestKey");
        isa_ok($created_item, "t::Redisism::TestKey");
        is($created_item->redis, $redis, "redis connection should be equal");
        is(!!$created_item->server_info->{redis_version}, 1, "redis_version OK");
    };
};

done_testing;

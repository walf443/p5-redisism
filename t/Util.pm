package t::Util;
use strict;
use warnings;
use Test::RedisServer;
use Test::More;

sub start_redis_server {
    my ($class, ) = @_;
    my $server;
    eval {
        $server = Test::RedisServer->new;
    }
        or plan skip_all => 'redis-server is required for this test';

    return $server;
}

sub get_redis_client_for {
    my ($class, $server) = @_;
    if ( $ENV{REDIS_CLIENT} && $ENV{REDIS_CLIENT} eq "RedisDB" ) {
        my %conn = $server->connect_info;
        eval { require RedisDB; };
        if ( $@ ) {
            plan skip_all => 'RedisDB is required for this test';
        };
        return RedisDB->new(path => $conn{sock});
    } else {
        my %conn = $server->connect_info;
        eval { require Redis; };
        if ( $@ ) {
            plan skip_all => 'Redis is required for this test';
        };
        return Redis->new(sock => $conn{sock});
    }
}

1;

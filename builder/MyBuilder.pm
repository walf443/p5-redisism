package builder::MyBuilder;
use strict;
use warnings;
use parent qw(Module::Build);

sub ACTION_test {
    my $self = shift;
    $self->ACTION_test_with_redis;
    $self->ACTION_test_with_redisDB;
}

sub ACTION_test_with_redis {
    my $self = shift;

    print qq{Testing: \$ENV{REDIS_CLIENT} = "Redis"\n};
    $self->SUPER::ACTION_test;
}

sub ACTION_test_with_redisDB {
    my $self = shift;

    print qq{Testing: \$ENV{REDIS_CLIENT} = "RedisDB"\n};
    local $ENV{REDIS_CLIENT} = "RedisDB";
    $self->SUPER::ACTION_test;
}

1;

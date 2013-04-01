package Redisism::SortedSet;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command('zadd', 2, writing => 1, alias => 'add');
__PACKAGE__->define_redis_command('zcard', 0, writing => 0, alias => 'length');
__PACKAGE__->define_redis_command('zcount', 2, writing => 0);
__PACKAGE__->define_redis_command('zincrby', 2, writing => 1);
# __PACKAGE__->define_redis_command('zinterstore', 2, writing => 1);
__PACKAGE__->define_redis_command('zrange', 3, writing => 0);
# __PACKAGE__->define_redis_command('zrevrangebyscore', 3, writing => 0);
__PACKAGE__->define_redis_command('zrank', 1, writing => 0);
__PACKAGE__->define_redis_command('zrem', 1, writing => 1, alias => 'remove');
__PACKAGE__->define_redis_command('zremrangebyrank', 2, writing => 1);
# __PACKAGE__->define_redis_command('zremrangebyscore', 2, writing => 1);
__PACKAGE__->define_redis_command('zrevrange', 3, writing => 0);
# __PACKAGE__->define_redis_command('zrevrangebyscore', 3, writing => 0);
__PACKAGE__->define_redis_command('zrevrank', 1, writing => 0);
__PACKAGE__->define_redis_command('zscore', 1, writing => 0);
# __PACKAGE__->define_redis_command('zunionstore', 3, writing => 1);

sub order_by {
    'DESC';
}

sub rank {
    my $class = shift;

    if ( $class->order_by eq 'ASC' ) {
        return $class->zrank(@_);
    } else {
        return $class->zrevrank(@_);
    }
}

sub range {
    my $class = shift;

    if ( $class->order_by eq 'ASC' ) {
        return $class->zrange(@_);
    } else {
        return $class->zrevrange(@_);
    }
}

1;
__END__

=head1 NAME

Redisism::SortedSet - Perl extention to do something

=head1 VERSION

This document describes Redisism::SortedSet version 0.01.

=head1 SYNOPSIS

    package YourProj::Redisism::SomeRanking;
    use parent qw(Redisism::SortedSet);

    sub order_by { 'DESC' } # 'DESC' OR 'ASC' ( DESC is default )

    package main;

    my $some_ranking = YourProj::Redisism::SomeRanking->new(
        redis => $redis
        namespace => 'YourProj::Redisism',
        key_prefix => 't',
    );
    $some_ranking->rank("test:1", id => 1); # zrevrank t:some_ranking:id:1 test:1

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< order_by() >>

rank() / range() consider order_by. ("DESC" or "ASC". default is "DESC")

=head3 C<< rank() >>

if order_by() return "DESC", It's alias of zrevrank.
if order_by() return "ASC", It's alias of zrank.

=head3 C<< range() >>

if order_by() return "DESC", It's alias of zrevrange.
if order_by() return "ASC", It's alias of zrange.

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, Keiji Yoshimi. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

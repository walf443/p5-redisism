package Redisism::List;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

# __PACKAGE__->define_redis_command("blpop", 0, writing => 1);
# __PACKAGE__->define_redis_command("brpop", 0, writing => 1);
# __PACKAGE__->define_redis_command("brpoplpush", 1, writing => 1);
__PACKAGE__->define_redis_command("lindex", 1, alias => 'index');
# __PACKAGE__->define_redis_command("linsert", 1, alias => 'index');
__PACKAGE__->define_redis_command("llen", 0, alias => 'length');
__PACKAGE__->define_redis_command("lpop", 0, writing => 1, alias => 'shift');
__PACKAGE__->define_redis_command("lpush", 1, writing => 1, alias => 'unshift');
__PACKAGE__->define_redis_command("lpushx", 1, writing => 1, alias => 'unshift_if_exists');
__PACKAGE__->define_redis_command("lrange", 2, alias => 'range');
__PACKAGE__->define_redis_command("lset", 2, writing => 1, alias => 'set');
__PACKAGE__->define_redis_command("lrem", 2, writing => 1, alias => 'remove');
__PACKAGE__->define_redis_command("ltrim", 2, writing => 1, alias => 'trim');
__PACKAGE__->define_redis_command("rpop", 0, writing => 1, alias => 'pop');
# __PACKAGE__->define_redis_command("rpoplpush", 1, writing => 1);
__PACKAGE__->define_redis_command("rpush", 1, writing => 1, alias => 'push');
__PACKAGE__->define_redis_command("rpushx", 1, writing => 1, alias => 'push_if_exists');

1;
__END__

=head1 NAME

Redisism::List - base class for redis list class.

=head1 VERSION

This document describes Redisism::List version 0.01.

=head1 SYNOPSIS

    package YourProj::Redisism::HotEntry;
    use parent qw(Redisism::List);

    1;

    my $redis = RedisDB->new;
    my $r_hot_entry = YourProj::Redisism::NewEntry->new(
        redis => $redis,
    );
    $r_hot_entry->lpush("item");
    my $new_item = $r_hot_entry->rpop();

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot com E<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, Keiji Yoshimi. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

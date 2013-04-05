package Redisism::Hash;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command("hdel", 1, writing => 1, alias => 'remove_field');
__PACKAGE__->define_redis_command("hexists", 0, writing => 0);
__PACKAGE__->define_redis_command("hget", 1, writing => 0, alias => 'get_field');
__PACKAGE__->define_redis_command("hgetall", 0, writing => 0, alias => 'get_all');
__PACKAGE__->define_redis_command("hincrby", 2, writing => 1);
__PACKAGE__->define_redis_command("hincrbyfloat", 2, writing => 1);
__PACKAGE__->define_redis_command("hkeys", 0, writing => 0, alias => 'keys');
__PACKAGE__->define_redis_command("hlen", 0, writing => 0, alias => 'length');
__PACKAGE__->define_redis_command("hmget", 0, writing => 0, alias => 'get_fields');
# __PACKAGE__->define_redis_command("hmset", 0, writing => 1, alias => 'set_fields');
__PACKAGE__->define_redis_command("hset", 2, writing => 1, alias => 'set_field');
__PACKAGE__->define_redis_command("hsetnx", 2, writing => 1, alias => 'set_field_if_not_exists');
__PACKAGE__->define_redis_command("hvals", 0, writing => 0, alias => 'values');

1;
__END__

=head1 NAME

Redisism::Hash - Perl extention to do something

=head1 VERSION

This document describes Redisism::Hash version 0.01.

=head1 SYNOPSIS

    use Redisism::Hash;

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

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, Keiji Yoshimi. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

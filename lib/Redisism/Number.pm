package Redisism::Number;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command("get", 0);
__PACKAGE__->define_redis_command("getset", 1, writing  => 1);
__PACKAGE__->define_redis_command("mget", 0, writing  => 0);
# __PACKAGE__->define_redis_command("mset", 1, writing  => 1);
# __PACKAGE__->define_redis_command("msetnx", 1, writing  => 1);
__PACKAGE__->define_redis_command("psetex", 2, writing  => 1);
__PACKAGE__->define_redis_command("set", 1, writing  => 1);
__PACKAGE__->define_redis_command("setex", 2, writing  => 1);
__PACKAGE__->define_redis_command("setnx", 1, writing  => 1);
__PACKAGE__->define_redis_command("strlen", 1, writing  => 1);

1;
__END__

=head1 NAME

Redisism::Number - Perl extention to do something

=head1 VERSION

This document describes Redisism::Number version 0.01.

=head1 SYNOPSIS

    use Redisism::Number;

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

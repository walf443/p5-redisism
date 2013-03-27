package Redisism::Set;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command("sadd", 1, writing => 1, alias => 'add');
__PACKAGE__->define_redis_command("scard", 0, writing => 0, alias => 'length');
# __PACKAGE__->define_redis_command("sdiff", 1, writing => 0);
# __PACKAGE__->define_redis_command("sdiffstore", 1, writing => 1);
# __PACKAGE__->define_redis_command("sinter", 1, writing => 0);
# __PACKAGE__->define_redis_command("sinterstore", 1, writing => 1);
__PACKAGE__->define_redis_command("sismember", 1, writing => 0);
__PACKAGE__->define_redis_command("smembers", 0, writing => 0);
# __PACKAGE__->define_redis_command("smove", 1, writing => 1);
__PACKAGE__->define_redis_command("spop", 0, writing => 1);
__PACKAGE__->define_redis_command("srandmember", 1, writing => 0);
# __PACKAGE__->define_redis_command("srem", 1, writing => 1);
# __PACKAGE__->define_redis_command("sunion", 1, writing => 0);
# __PACKAGE__->define_redis_command("sunionstore", 1, writing => 1);

1;
__END__

=head1 NAME

Redisism::Set - Perl extention to do something

=head1 VERSION

This document describes Redisism::Set version 0.01.

=head1 SYNOPSIS

    use Redisism::Set;

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

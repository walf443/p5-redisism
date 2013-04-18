package Redisism::Int;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Number);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command("incr", 0, writing => 1);
__PACKAGE__->define_redis_command("decr", 0, writing => 1);
__PACKAGE__->define_redis_command("incrby", 1, writing => 1);
__PACKAGE__->define_redis_command("decrby", 1, writing => 1);

1;
__END__

=head1 NAME

Redisism::Int - Perl extention to do something

=head1 VERSION

This document describes Redisism::Int version 0.01.

=head1 SYNOPSIS

    use Redisism::Int;

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

package Redisism::Float;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Number);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command("incrbyfloat", 1, writing => 1, alias => 'incrby');

1;
__END__

=head1 NAME

Redisism::Float - Perl extention to do something

=head1 VERSION

This document describes Redisism::Float version 0.01.

=head1 SYNOPSIS

    use Redisism::Float;

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

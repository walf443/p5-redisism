package Redisism::SortedSet;
use 5.008_001;
use strict;
use warnings;
use parent qw(Redisism::Base);

our $VERSION = '0.01';

__PACKAGE__->define_redis_command('zadd', 2, writing => 1, alias => 'add');
__PACKAGE__->define_redis_command('zcard', 0, writing => 1, alias => 'length');
__PACKAGE__->define_redis_command('zcount', 2, writing => 1);
__PACKAGE__->define_redis_command('zincrby', 2, writing => 1);
# __PACKAGE__->define_redis_command('zinterstore', 2, writing => 1);
__PACKAGE__->define_redis_command('zrange', 3, writing => 1);
__PACKAGE__->define_redis_command('zrank', 1, writing => 1, alias => 'rank');
__PACKAGE__->define_redis_command('zrem', 1, writing => 1, alias => 'remove');
__PACKAGE__->define_redis_command('zremrangebyrank', 2, writing => 1);
# __PACKAGE__->define_redis_command('zremrangebyscore', 2, writing => 1);
__PACKAGE__->define_redis_command('zrevrange', 3, writing => 1);
__PACKAGE__->define_redis_command('zrevrangebyscore', 3, writing => 1);
__PACKAGE__->define_redis_command('zrevrank', 1, writing => 1);
__PACKAGE__->define_redis_command('zscore', 1, writing => 1);
# __PACKAGE__->define_redis_command('zunionstore', 3, writing => 1);

1;
__END__

=head1 NAME

Redisism::SortedSet - Perl extention to do something

=head1 VERSION

This document describes Redisism::SortedSet version 0.01.

=head1 SYNOPSIS

    use Redisism::SortedSet;

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

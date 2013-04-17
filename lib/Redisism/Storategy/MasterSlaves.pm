package Redisism::Storategy::MasterSlaves;
use 5.008_001;
use strict;
use warnings;

our $VERSION = '0.01';

use Class::Accessor::Lite (
    new => 1,
    ro => [qw(master slave)],
);

sub get_code {
    my ($self, ) = @_;
    return sub {
        my ($target, @args) = @_;

        my $writing_index = index(@args, 'writing');
        if ( $writing_index >= 0 && $args[$writing_index+1] ) {
            if ( ref $self->master eq 'CODE' ) {
                return $self->master->($target, @args);
            } else {
                return $self->master;
            }
        } else {
            if ( ref $self->slave eq 'CODE' ) {
                return $self->slave->($target, @args);
            } else {
                return $self->slave;
            }
        }
    };
}


1;
__END__

=head1 NAME

Redisism::Storategy::MasterSlaves - take master resis server if writing comand or not take slaves.

=head1 VERSION

This document describes Redisism::Storategy::MasterSlaves version 0.01.

=head1 SYNOPSIS

    use Redisism::Factory;
    use Redisism::Storategy::MasterSlaves;
    my $redis_master = RedisDB->new;
    my $redis_slave  = RedisDB->new;
    my $storategy = Redisism::Storategy::MasterSlaves->new(
        master => $redis_master,
        slave => $redis_slave,
    );
    my $factory = Redisism::Factory->new(
        namespace => "YourProj::Redisism",
        redis => $storategy->get_code(),
    );

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< get_code() >>

return CODE reference. That can use with Reidisism class's constructor.

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

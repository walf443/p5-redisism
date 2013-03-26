package Redisism::Factory;
use 5.008_001;
use strict;
use warnings;
use Class::Load qw();
our $VERSION = '0.01';

use Class::Accessor::Lite (
    new => 1,
    ro => [qw(redis namespace key_prefix)],
    rw => [qw(server_info)],
);

sub create {
    my ($self, $class, %options) = @_;

    my $target = $class =~ /^\+(.+)$/ ? $1 : $self->namespace . "::" . $class;
    Class::Load::load_class($target);

    unless ( $self->server_info ) {
        $self->server_info($self->redis->info("server"));
    }

    return $target->new(
        redis => $self->redis,
        server_info => $self->server_info,
        key_prefix => $self->key_prefix,
        namespace => $self->namespace,
        %options
    );
}

1;
__END__

=head1 NAME

Redisism::Factory - Factory class for Redisism instance.

=head1 VERSION

This document describes Redisism::Factory version 0.01.

=head1 SYNOPSIS

    use Redisism::Factory;

    my $redis = RedisDB->new;
    my $factory = Redisism::Factory->new(
        redis => $redis,
        key_prefix => 'your_proj',
        namespace => "YourProj::Redisism",
    );
    my $some_key = $factory->create("SomeKey"); #=> get instance of YourProj::Redisism::SomeKey with $redis

=head1 DESCRIPTION

This class create your Redisism class. You may want to register this factory class to DI Container like L<Object::Container>.

=head1 INTERFACE

=head2 Functions

=head3 C<< create($name, %options) >>

create $name class under namespace. if $name start with "+", $name considered as absolute path.

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

<<YOUR NAME HERE>> E<lt><<YOUR EMAIL ADDRESS HERE>>E<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, <<YOUR NAME HERE>>. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

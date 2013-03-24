package Redisism::Base;
use 5.008_001;
use strict;
use warnings;
our $VERSION = '0.01';
use Carp qw();

use Class::Accessor::Lite (
    new => 1,
    ro => [qw( namespace redis server_info )],
);

sub get_redis {
    my ($self, @args) = @_;
    my $redis = $self->redis;
    if ( ref $redis eq 'CODE' ) {
        return $redis->(@args);
    } else {
        return $redis;
    }
}

sub generate_key {
    my ($self, @args) = @_;
    if ( $self->namespace ) {
        return $self->namespace . ":" . ref($self) . join(":", @args);
    } else {
        return ref($self) . ":" . join(":", @args);
    }
}

# you should override this method if you handle non-parsistent key.
sub expires_in { }

sub define_command {
    my ($class, $cmd, $numarg, %options) = @_;
    no strict 'refs';
    *{$class . "::" . $cmd} = sub {
        my ($self, @args) = @_;
        my @cmdargs = $numarg ? splice(@args, 0, $numarg) : ();
        my $last_arg = $numarg ? pop @cmdargs : undef;
        my $key = $self->generate_key(@args);
        if ( defined($last_arg) ) {
            if ( ref $last_arg eq "ARRAY" ) {
                push @cmdargs, @{ $last_arg };
            } else {
                push @cmdargs, $last_arg;
            }
        } else {
            # pass through.
        }
        my $cmd_result;
        eval {
            $cmd_result = $self->get_redis(server_info => $self->server_info || {}, command => $cmd, %options, @args)->$cmd($key, @cmdargs);
        };
        if ( $@ ) {
            chomp $@;
            Carp::croak($@);
        } else {
            return $cmd_result;
        }
    };
    if ( $options{alias} ) {
        *{$class . "::" . $options{alias}} = *{$class . "::" . $cmd};
    }
}

__PACKAGE__->define_command("del", 0,  writing => 1, alias => 'delete');
__PACKAGE__->define_command("exists", 0, writing => 0);
__PACKAGE__->define_command("type", 0, writing => 0);
__PACKAGE__->define_command("ttl", 0, writing => 0);
__PACKAGE__->define_command("dump", 0, writing => 0);

1;
__END__

=head1 NAME

Redisism::Base - base class for application.

=head1 VERSION

This document describes Redisism::Base version 0.01.

=head1 SYNOPSIS

    package YourProj::Redisism::SomeKey;
    use parent qw(Redisism::Base);

    sub expire_in { 100 }

    1;

    package main;

    my $redis = RedisDB->new;
    $some_key = YourProj::Redisism::SomeKey->new(
        redis => $redis,
    );
    $some_key->setex(1 => 1000); # setex your_proj:some_key:1 100 1000
    $some_key->get(1) #=> 100; # get your_proj:some_key:1
    $some_key->delete(1); # del your_proj:some_key:1

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< generate_key(@args) >>

=head3 C<< get_redis(@args) >>

=head3 C<< expires_in() >>

=head3 C<< define_command() >>

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

<<YOUR NAME HERE>> E<lt><<YOUR EMAIL ADDRESS HERE>>E<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2013, <<YOUR NAME HERE>>. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

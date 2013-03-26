package Redisism::Base;
use 5.008_001;
use strict;
use warnings;
our $VERSION = '0.01';
use Carp qw();
use String::CamelCase qw();

use Class::Accessor::Lite (
    new => 1,
    ro => [qw( redis key_prefix server_info namespace)],
);

sub get_redis {
    my ($self, @args) = @_;
    my $redis = $self->redis;
    if ( ref $redis eq 'CODE' ) {
        return $redis->($self, @args);
    } else {
        return $redis;
    }
}

sub generate_key {
    my ($self, @args) = @_;
    return $self->base_key . ":" . join(":", @args);
}

sub base_key {
    my ($self, ) = @_;

    if ( !$self->{__base_key} ) {
        if ( $self->namespace ) {
            my $full = ref($self);
            $self->{__namespace_regex} ||= qr{^$self->namespace::(.+)$};
            if ( $full =~ $self->{__namespace_regex} ) {
                my $relative = $1;
                $self->{__base_key} = join ':', map { String::CamelCase::decamelize($1) } split /::/, $relative;
            }
        } else {
            $self->{__base_key} = ref($self);
        }
    }

    return $self->{__base_key};
}

# you should override this method if you handle non-parsistent key.
sub expires_in { }

sub define_redis_command {
    my ($class, $cmd, $numarg, %options) = @_;
    my $code = sub {
        my ($self, @args) = @_;
        my @cmdargs = $numarg ? splice(@args, 0, $numarg) : ();
        my $last_arg = $numarg ? pop @cmdargs : undef;
        my $key = $self->generate_key(@args);
        if ( $self->key_prefix ) {
            $key = $self->key_prefix . ":" . $key;
        }
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
    no strict 'refs';
    *{$class . "::" . $cmd} = $code;
    if ( $options{alias} ) {
        *{$class . "::" . $options{alias}} = *{$class . "::" . $cmd};
    }
    use strict 'refs';
    $code;
}

__PACKAGE__->define_redis_command("del", 0,  writing => 1, alias => 'delete');
__PACKAGE__->define_redis_command("exists", 0, writing => 0);
__PACKAGE__->define_redis_command("type", 0, writing => 0);
__PACKAGE__->define_redis_command("ttl", 0, writing => 0);
__PACKAGE__->define_redis_command("dump", 0, writing => 0);

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
    $some_ky->setex(1 => 1000); # setex your_proj:some_key:1 100 1000
    $some_key->get(1) #=> 100; # get your_proj:some_key:1
    $some_key->delete(1); # del your_proj:some_key:1

=head1 DESCRIPTION

Base class of other Reidisim classes. You should not inherit this class directly.

=head1 INTERFACE

=head2 Functions

=head3 C<< generate_key(@args) >>

=head3 C<< base_key(@args) >>

base_key is Redis's key which does not contain dynamic elements. base_key does not contain key_prefix.
base_key is defined from a package name automatically (decamelized relative package name). If you'd like to use your own rule, you can override it from your subclass.

=head3 C<< get_redis(@args) >>

=head3 C<< expires_in() >>

=head3 C<< define_redis_command() >>

=head3 C<< del(@generate_key_args) / delete(@generate_key_args) >>
run L<del|http://redis.io/commands/del> command with generate_key(@generate_key_args).

=head3 C<< exists(@generate_key_args) >>
run L<exists|http://redis.io/commands/exists> command with generate_key(@generate_key_args).

=head3 C<< type(@generate_key_args) >>
run L<type|http://redis.io/commands/type> command with generate_key(@generate_key_args).

=head3 C<< ttl(@generate_key_args) >>
run L<ttl|http://redis.io/commands/ttl> command with generate_key(@generate_key_args).

=head3 C<< dump(@generate_key_args) >>
run L<dump|http://redis.io/commands/dump> command with generate_key(@generate_key_args).

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

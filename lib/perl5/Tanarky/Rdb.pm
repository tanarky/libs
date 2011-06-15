#!/usr/bin/perl

package Tanarky::Rdb;

use strict;
use warnings;
use Data::Dumper;

use DBI;

use base qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/handle sth/);

sub connect {
    my ($self, $conf) = @_;
    return 1 if($self->handle());
    my $h = DBI->connect(
        $conf->{dsn},
        $conf->{user},
        $conf->{password},
        $conf->{options},
        );
    return 0 if(!$h);
    $self->handle($h);
    return 1;
}
sub DESTROY {
    my ($self) = @_;
    $self->cleanup;
}
sub begin {
    my ($self) = @_;
    return 0 if(!$self->handle());
    return $self->handle()->begin_work();
}
sub commit {
    my ($self) = @_;
    return 0 if(!$self->handle());
    return $self->handle()->commit();
}
sub rollback {
    my ($self) = @_;
    return 0 if(!$self->handle());
    return $self->handle()->rollback();
}
sub disconnect {
    my ($self) = @_;
    return 1 if(!$self->handle());
    return 0 if(!$self->cleanup());
    return $self->handle()->disconnect();
}
sub cleanup {
    my ($self) = @_;
    return 1 if(!$self->sth());
    return $self->sth()->finish();
}
sub exec {
    my ($self, $sql, @placeholder) = @_;
    $self->cleanup if($self->sth());
    my $s = $self->handle()->prepare($sql);
    return 0 if(!$s);
    $self->sth($s);
    return $self->sth()->execute(@placeholder);
}
sub pop {
    my ($self) = @_;
    return undef if(!$self->sth());
    return $self->sth()->fetchrow_hashref();
}

1;

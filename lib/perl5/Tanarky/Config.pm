#!/usr/bin/perl

package Tanarky::Config;

use strict;
use warnings;
use Data::Dumper;

use Config::Any;

sub load {
    my $c = Config::Any->load_files(
        {files   => \@_,
         use_ext => 1,
         flatten_to_hash => 1});
    return $c;
}

1;

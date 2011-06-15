#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use utf8;

use Tanarky::Rdb;

my $db = new Tanarky::Rdb;
#my $conf = { dsn => "dbi:SQLite:dbname=/tmp/test.sqlite" };
#my $conf = { dsn => "DBI:mysql:test;host=localhost", user => "root", password => "",  };
warn $db->connect($conf);
warn $db->begin();

## splite
#my $sql = 'create table contents ("url" text primary key, "content" blob, "updated_at" integer);';
## mysql
#my $sql = 'create table foo ( `id` int );';

warn $db->exec($sql);

warn $db->commit();

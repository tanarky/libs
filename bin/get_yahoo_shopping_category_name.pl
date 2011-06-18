#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use utf8;
use Encode;
use URI::Escape;
use Getopt::Long;

use LWP::UserAgent;
use Tie::File;

use Tanarky::Config;
use Tanarky::Rdb;

GetOptions(
    '-section=s'  => \$::opts{section},
    '-conf=s'     => \$::opts{conf},
    '-force'      => \$::opts{force},
    );
die if(!$::opts{section});
die if(!$::opts{conf} || !-f $::opts{conf});

my $cf = $::opts{conf};
my $co = Tanarky::Config::load($cf);
my $file;
die unless($co->{$cf}->{$::opts{section}}->{dsn} =~ /dbname=(.*)$/);
$file = $1;
unlink $file if(-f $file);

my $db  = new Tanarky::Rdb();
die unless($db);
die unless($co->{$cf}->{$::opts{section}});
die unless($db->connect($co->{$cf}->{$::opts{section}}));
my $sql = 'create table categories ("id" integer primary key, "name" text, "updated_at" integer);';
die 'create failed.' if(!$db->exec($sql));

my $tmp_file = '/tmp/category_sitemap.xml';
my $org_url  = 'http://shopping.yahoo.co.jp/sitemap/category_sitemap.xml';

my $ua = new LWP::UserAgent;
$ua->timeout(10);

my $res = $ua->get($org_url, ':content_file' => $tmp_file);
die 'failed:'. $res->status_line if(!$res->is_success);

tie my @file, 'Tie::File', $tmp_file or die 'cant open file '. $tmp_file;
foreach my $l (@file) {
    next unless($l =~ m|CDATA\[http://category.shopping.yahoo.co.jp/list/(.*?)/(.*)/\]|g);
    $sql = 'insert or replace into categories (id,name,updated_at) values (?, ?, '.time().');';
    warn 'insert failed.' if(!$db->exec($sql, $2, uri_unescape($1)));
}



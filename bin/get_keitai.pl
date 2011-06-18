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
use Date::Manip;

use Tanarky::Config;
use Tanarky::Rdb;
use XML::Simple;

GetOptions(
    '-section=s'  => \$::opts{section},
    '-conf=s'     => \$::opts{conf},
    '-force'      => \$::opts{force},
    '-init'       => \$::opts{init},
    );
die if(!$::opts{section});
die if(!$::opts{conf} || !-f $::opts{conf});

my $cf = $::opts{conf};
my $co = Tanarky::Config::load($cf);
my $file;
my $sql;
die unless($co->{$cf}->{$::opts{section}}->{dsn} =~ /dbname=(.*)$/);

my $db  = new Tanarky::Rdb();
die unless($db);
die unless($co->{$cf}->{$::opts{section}});
if($::opts{init}){
    $file = $1;
    unlink $file if(-f $file);
    die if(-f $file);
}
die unless($db->connect($co->{$cf}->{$::opts{section}}));
if($::opts{init}){
    $sql = 'create table keitai ("carrier" text, "model" text UNIQUE, "vendor" text, "released_at" integer);';
    die 'create failed.'. Dumper($db) if(!$db->exec($sql));
}

my $tmp_file = '/tmp/keitai.xml';
my $org_url  = 'http://keitaiall.jp/inc/choice.xml?t='. time(). '30';
warn $org_url;
my $ua = new LWP::UserAgent(agent => 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)');
$ua->timeout(10);
my $res = $ua->get($org_url, ':content_file' => $tmp_file);
die 'failed:'. $res->status_line if(!$res->is_success);

my $xs  = new XML::Simple(forcearray => 1);
my $xml = $xs->XMLin($tmp_file);

$sql = 'insert or replace into keitai (carrier,model,vendor,released_at) values (?,?,?,?);';
$db->begin();
$db->prepare($sql);
foreach my $d (@{$xml->{device_profile}}){
    my $carrier = lc($d->{carir_name}[0]->{content});
    my $model   = lc($d->{devc_idnty_name}[0]->{content});
    my $vendor  = lc($d->{vndr_name}[0]->{content});
    my $release = UnixDate($d->{off_air_date}[0]->{content}, "%s");

    if($db->execute($carrier, $model, $vendor, $release)){
        warn 'insert success:'. $model;
    }
    else {
        warn 'insert failed:'. $model;
    }
}
warn( $db->commit() ? 'commit success' : 'commit failed' );


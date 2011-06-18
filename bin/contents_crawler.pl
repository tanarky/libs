#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use utf8;
use Encode;

use LWP::Simple;
use Parallel::ForkManager;
use Getopt::Long;

use Tanarky::Config;
use Tanarky::Rdb;

GetOptions(
    '-section=s'  => \$::opts{section},
    '-conf=s'     => \$::opts{conf},
    '-force'      => \$::opts{force},
    '-parallel=s' => \$::opts{parallel},
    );

die if(!$::opts{section});
die if(!$::opts{conf} || !-f $::opts{conf});
$::opts{parallel} = 1 if(!$::opts{parallel});
my $pm = Parallel::ForkManager->new($::opts{parallel});
my $cf = $::opts{conf};
my $co = Tanarky::Config::load($cf);

while(<>){
    $pm->start and next;
    chomp;
    my $sql;
    my $url = $_;
    my $rec = undef;
    my $db  = new Tanarky::Rdb();
    die unless($db);
    die unless($co->{$cf}->{$::opts{section}});
    die unless($db->connect($co->{$cf}->{$::opts{section}}));

    if(!$::opts{force}){
        $sql = 'select `url`, `updated_at` from contents where `url`=? limit 1';
        $db->exec($sql, $url);
        $rec = $db->pop();
        $db->cleanup();
    }

    if(!$rec){
        my $content = get($url);
        if($content){
            $content = Encode::decode_utf8($content);
            # insert empty or ignore
            $sql = 'insert or ignore into contents (url,contents,updated_at) values (?, "", '.time().');';
            if($db->exec($sql, $url)){
                $sql = "update contents set contents=? where url = ?;";
                warn 'update failed' if(!$db->exec($sql, Encode::encode_utf8($content), $url));
            }
            else {
                warn 'insert failed' ;
            }
        }
        else{
            warn "content get failed [$url]";
        }
    }
    else {
        warn "content exist [$url]";
    }
    $pm->finish;
}
$pm->wait_all_children;

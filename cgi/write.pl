#!/usr/bin/perl
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use utf8;
use Encode;
$q = new CGI;
print <<EOF;
Content-type: text/plain

Write Ok
EOF
open (WR,">>log.txt");
my $name = decode ('utf-8',$q->param('name'));
my $msg  = decode ('utf-8',$q->param('msg'));
$name = $q->escapeHTML($name);
$msg  = $q->escapeHTML($msg);


my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdat) = localtime time;
my $jikan=sprintf("%04d/%02d/%02d %02d:%02d:%02d",$year+1900,$mon,$mday,$hour,$min,$sec);

print WR "$jikan ","$name  ( ﾟДﾟ)"  ,"$msg\n";
close WR;

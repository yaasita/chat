#!/usr/bin/perl
use DBI;
use POSIX 'strftime';
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use utf8;
use Encode;
$q = new CGI;
print <<EOF;
Content-type: text/plain

Write Ok
EOF
my $name = decode ('utf-8',$q->param('name'));
my $msg  = decode ('utf-8',$q->param('msg'));
$name = $q->escapeHTML($name);
$msg  = $q->escapeHTML($msg);

my $db = DBI->connect('DBI:mysql:chat:localhost','perl','passwd') or die $!;
my $current_datetime = strftime( "%Y-%m-%d %H:%M:%S" , localtime );
$sql = $db->prepare("insert into log values(null,'$current_datetime',?,?)");
$sql->execute($name,$msg);
$sql->finish;
$db->disconnect;


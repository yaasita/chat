#!/usr/bin/perl
use DBI;
use utf8;
use Encode;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $etag=time();
print <<EOF;
Content-type: text/plain
Cache-Control: no-cache
ETag: "$etag"

EOF

my $db = DBI->connect('DBI:mysql:chat:localhost','perl','hyper') or die $!;
$sql = $db->prepare("select * from log where id>=?");
$q = new CGI;
$sql->execute($q->param('log'));
my $kao='( ﾟДﾟ)';
while (my @rec = $sql->fetchrow_array){
	$rec[2]=decode "utf-8",$rec[2];
	$rec[3]=decode "utf-8",$rec[3];
	print encode ("utf-8","<tr id='$rec[0]'><td>$rec[1]</td><td>$rec[2]</td><td>$kao $rec[3]</td></tr>\n");
}
$sql->finish;
$db->disconnect;


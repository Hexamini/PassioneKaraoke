#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use XML::LibXML;

use Page::Object::Base::Check;
use Page::Object::Base::ParserXML;
    
my $cgi = new CGI;

my $nick = $cgi->param( 'artistNick' );
my $image = $cgi->param( 'artistImage' );
my $description = $cgi->param( 'artistDescription' );

my $qManager = 
    'r.cgi?section=artistManager&id=0&mode=edit'.
    "&s=$nick&s=$born&s=$death&s=$description";

my $err = '';

#Controllo campi input
if ( Check::check( $nick, 'artistNick' ) == 0 ) {
    $err = $err.'&e=Nome d\'arte non valido, inserire un testo'.
	'che presenti solo lettere e numeri'
} if ( Check::check( $image, 'artistImage' ) == 0 ) {
    $err = $err.'&e=Nome immagine non valido, inserire un testo'.
	'che presenti solo lettere e numeri comprensivo del formato dell\'immagine';
}
#Se uno dei test ha riscontrato errori vieni fatto il redirect su artistManger
if ( $err ne '' ) {
    $qManager = $qManager.$err;
    
}

my $id = $nick;
$id =~ s/\s+//g;
$id = lc $id;

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $framment = 
    "<artist id='$id' >
       <nick><![CDATA[$nick]]></nick>
       <image>$image</image>
       <description><![CDATA[$description]]></description>
    </artist>";

my $artist = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( 'xs:artistList' )->get_node( 1 );

$root->appendChild( $artist ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( 'r.cgi?section=artists&mode=edit' );


#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use XML::LibXML;

use Page::Object::Base::ParserXML;
use Page::Object::Base::Check;
    
my $cgi = new CGI;

my $author = $cgi->param( 'artistName' );
my $name = $cgi->param( 'albumName' );
my $image = $cgi->param( 'albumImage' );
my $js = $cgi->param( 'javascript' );

my $qManager = 'r.cgi?section=albumManager&artist=fedez&album=0&mode=edit'.
    "&s=$name&s=$image";

my $err = '';

if ( !$js ) {
    #Controllo campi input
    if ( !Check::check( $name, 'albumName' ) ) {
	$err = $err.'&e=Nome album non valido, inserire solo lettere o numeri'.
	    '&i=album-name';
    } if ( !Check::check( $image, 'albumImage' ) ) {
	$err = $err.'&e=Nome immagine non valido, inserire un testo presenti'.
	    'solo lettere e numeri comprensivo del formato dell\'immagine'.
	    '&i=album-image';
    }
}

#Se uno dei test ha riscontrato errori viene fatto il redirect su albumManager
if ( $err ne '' ) {
    $qManager = $qManager.$err;
    print $cgi->redirect( $qManager );
} else {
    my $file = '../data/database/artistlist.xml';

    my $parser = XML::LibXML->new();
    my $doc = ParserXML::getDoc( $parser, $file );

    my $id = '_' . $name;
    $id =~ s/\s+//g;
    $id = lc $id;

    my $framment = 
	"<album id='$id'>
       <name><![CDATA[$name]]></name>
       <image>$image</image>
     </album>";

    my $album = $parser->parse_balanced_chunk( $framment )
	|| die( 'Frammento non ben formato' );
    my $root = $doc->findnodes( "//xs:artist[\@id='$author']" )->get_node( 1 );

    $root->appendChild( $album ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    print $cgi->redirect( "r.cgi?section=artist&id=$author&mode=edit" );
}




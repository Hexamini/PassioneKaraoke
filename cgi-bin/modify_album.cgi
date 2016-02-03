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

my $idArtist = $cgi->param( 'artistName' );
my $idAlbum = $cgi->param( 'albumId' );
my $name = $cgi->param( 'albumName' );
my $image = $cgi->param( 'albumImage' );

my $qManager = 
    'r.cgi?section=albumManager'.
    "&artist=$idArtist&album=$idAlbum&mode=modify&s=$name&s=$image";

my $err = '';

if ( !Check::check( $name, 'albumName' ) ) {
    $err = $err.'&e=Nome album non valido, inserire solo lettere o numeri';
} if ( !Check::check( $image, 'albumImage' ) ) {
    $err = $err.'Nome immagine non valido, inserire un testo presenti solo'.
	'lettere e numeri comprensivo del formato dell\'immagine';
}

if ( $err ne '' ) {
    $qManager = $qManager.$err;
    print $cgi->redirect( -uri => $qManager );
} else {
    my $file = '../data/database/artistlist.xml';

    my $parser = XML::LibXML->new();
    my $doc = ParserXML::getDoc( $parser, $file );

    my $album = $doc->findnodes( 
	"//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']" 
	)->get_node( 1 );

    if( $name )
    {
	#Aggiorno l'id
	$idAlbum = '_' . $name;
	$idAlbum =~ s/\s+//g;
	$idAlbum = lc $idAlbum;

	$album->setAttribute( 'id', $idAlbum );

	$album->removeChild( $album->findnodes( 'xs:name' )->get_node( 1 ) );

	my $name = $parser->parse_balanced_chunk( "<name><![CDATA[$name]]></name>" ) 
	    || die( 'Frammento non ben formato' );
	$album->appendChild( $name );
    }

    if( $image )
    {
	$album->removeChild( $album->findnodes( 'xs:image' )->get_node( 1 ) );

	my $image = $parser->parse_balanced_chunk( "<image>$image</image>" ) || 
	    die( 'Frammento non ben formato' );

	$album->appendChild( $image );
    }

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    print $cgi->redirect( -uri => "r.cgi?section=artist&id=$idArtist&mode=edit" );
}

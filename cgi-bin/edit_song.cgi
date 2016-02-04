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

my $name = $cgi->param( 'songTitle' );
my $artist = $cgi->param( 'songArtist' );
my $album = $cgi->param( 'songAlbum' );
my $lyrics = $cgi->param( 'songLyrics' );
my $extra = $cgi->param( 'songExtra' );
my $js = $cgi->param( 'javascript' );

#Aggiunta di uno spazio dopo una nuova linea
$lyrics =~ s/\n/\n /g;

my $qManager =
    'r.cgi?section=songManager&'.
    "idArtist=$artist&album=$album&song=0&mode=edit&s=$name".
    "&s=$lyrics&s=$extra";

my $err = '';

if ( !$js ) {
    #Controllo campi input
    if ( !Check::check( $name, 'songTitle' ) ) {
	$err = $err . '&e=Titolo della canzone errato, inserire un testo che presenti '.
	    'solo lettere e numeri&i=song-title';
    } if ( !Check::check( $lyrics, 'songLyrics' ) ) {
	$err = $err . '&e=Il testo della canzone e\' vuoto&i=song-lyrics';
    } if ( !Check::check( $extra, 'songExtra' ) ) {
	$err = $err . '&e=Formato del link non riconosciuto. Deve essere preso solo il '.
	    '"XXXXXX" del link in esempio: https://www.youtube.com/embed/XXXXXX'.
	    '&i=song-lyrics';
    }
}

if ( $err ne '' ) {
    $qManager = $qManager . $err;
    print $cgi->redirect( -uri => $qManager );
} else {
    my $id = '_' . $name;
    $id =~ s/\s+//g;
    $id = lc $id;

    #Sezione aggiunta canzoni nel database
    my $framment = 
	"<song id='$id'>
       <name><![CDATA[$name]]></name>
       <lyrics><![CDATA[$lyrics]]></lyrics>
       <extra>$extra</extra>
       <grades>0</grades>
     </song>";

    my $file = '../data/database/artistlist.xml';
    my $parser = XML::LibXML->new();
    my $doc = ParserXML::getDoc( $parser, $file );

    my $song = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
    my $root = $doc->findnodes( "/xs:artistList/xs:artist[\@id='$artist']/xs:album[\@id='$album']" )->get_node( 1 );

    $root->appendChild( $song ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

#Sezione per l'aggiornamento dell'ultima canzone
    $file = '../data/database/news.xml';
    $doc = ParserXML::getDoc( $parser, $file );

    $framment = "<newSong id='$id' artist='$artist' album='$album'><![CDATA[$name]]></newSong>";

    my $newSong = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );

    $root = $doc->findnodes( '//xs:songs' )->get_node( 1 );

    if ( $root->findnodes( '*' )->size() == 5 ) {
	my $oldNode = $root->findnodes( 'xs:newSong[1]' )->get_node( 1 );
	$root->removeChild( $oldNode );
    }    

    $root->appendChild( $newSong ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    print $cgi->redirect( -uri => "r.cgi?section=artist&amp;id=$artist&amp;mode=edit" );
}

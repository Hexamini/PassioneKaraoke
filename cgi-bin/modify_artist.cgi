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

my $id = $cgi->param( 'idArtist' );
my $nick = $cgi->param( 'artistNick' );
my $image = $cgi->param( 'artistImage' );
my $description = $cgi->param( 'artistDescription' );
my $js = $cgi->param( 'javascript' );

#Aggiunge ad uno spazio bianco dopo una nuova riga
$description =~ s/\n/\n /g;

my $qManager = 
    "r.cgi?section=artistManager&id=$id&mode=modify".
    "&s=$nick&s=$image&s=$description";

my $err = '';

if ( !$js ) {
#Controllo campi input
    if ( !Check::check( $nick, 'artistNick' ) ) {
	$err = $err.'&e=Nome d\'arte non valido, inserire un nome di almeno '.
	    'due caratteri e che presenti solo lettere e numeri&i=a-Nick'
    } if ( !Check::check( $image, 'artistImage' ) ) {
	$err = $err.'&e=Nome immagine non valido, inserire un testo '.
	    'che presenti solo lettere e numeri comprensivo del formato '.
	    'dell\'immagine&i=a-Image';
    } if ( !Check::check( $description, 'artistDescription' ) ) {
	$err = $err.'&e=La descrizione e\' vuota&i=a-Description';
    }
}

if ( $err ne '' ) {
    $qManager = $qManager.$err;
    print $cgi->redirect( -uri => $qManager );
} else {

    my $file = '../data/database/artistlist.xml';

    my $parser = XML::LibXML->new();
    my $doc = ParserXML::getDoc( $parser, $file );
    
    my $artist = $doc->findnodes( "//xs:artist[\@id='$id']" )->get_node( 1 );

    if( $nick )
    {
	my $fileNews = '../data/database/news.xml';
	my $docNews = ParserXML::getDoc( $parser, $fileNews );

	my @newSongs = $docNews->findnodes( "//xs:newSong[\@artist='$id']" );
	
	#Aggiorno l'id
	$id = $nick;
	$id =~ s/\s+//g;
	$id = lc $id;

	#Aggiornamento id per le news che si riferiscono all'utente
	if ( scalar @newSongs > 0 ) {
	    foreach my $newSong( @newSongs ) {
		$newSong->setAttribute( 'artist', $id );
	    }

	    open( OUT, ">$fileNews" );
	    print OUT $doc->toString;
	    close( OUT );
	}
	
	$artist->setAttribute( 'id', $id );

	$artist->removeChild( $artist->findnodes( 'xs:nick' )->get_node( 1 ) );
	
	$nick = $parser->parse_balanced_chunk( "<nick><![CDATA[$nick]]></nick>" ) 
	    || die( 'Frammento non ben formato' );
	$artist->appendChild( $nick );
    }

    if( $image )
    {
	$artist->removeChild( $artist->findnodes( 'xs:image' )->get_node( 1 ) );
    
	$image = $parser->parse_balanced_chunk( "<image>$image</image>" ) 
	    || die( 'Frammento non ben formato' );
	$artist->appendChild( $image );
    }

    if( $description )
    {
	$artist->removeChild( $artist->findnodes( 'xs:description' )->get_node( 1 ) );

	$description = $parser->parse_balanced_chunk( 
	    "<description><![CDATA[$description]]></description>"
	) || die( 'Frammento non ben formato' );
	$artist->appendChild( $description );
    }

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    print $cgi->redirect( -uri => "r.cgi?section=artist&amp;id=$id&amp;mode=edit" );
}


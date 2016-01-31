#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use XML::LibXML;

use Page::Object::Base::ParserXML;
    
my $cgi = new CGI;

my $idArtist = $cgi->param( 'songArtist' );
my $idAlbum = $cgi->param( 'songAlbum' );
my $idSong = $cgi->param( 'songId' );
my $name = $cgi->param( 'songTitle' );
my $lyrics = $cgi->param( 'songLyrics' );
my $extra = $cgi->param( 'songExtra' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $song = $doc->findnodes( 
      "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']/".
      "xs:song[\@id='$idSong']" 
    )->get_node( 1 );

if( $name )
{
    #Aggiorno l'id
    $idSong = '_' . $name;
    $idSong =~ s/\s+//g;
    $idSong = lc $idSong;

    $song->setAttribute( 'id', $idSong );
    
    $song->removeChild( $song->findnodes( 'xs:name' )->get_node( 1 ) );

    my $name = $parser->parse_balanced_chunk( "<name><![CDATA[$name]]></name>" ) || die( 'Frammento non ben formato' );
    $song->appendChild( $name );
}

if( $lyrics )
{
    $song->removeChild( $song->findnodes( 'xs:lyrics' )->get_node( 1 ) );

    my $lyrics = $parser->parse_balanced_chunk( "<lyrics><![CDATA[$lyrics]]></lyrics>" ) || die( 'Frammento non ben formato' );
    $song->appendChild( $lyrics );
}

if( $extra )
{
    $song->removeChild( $song->findnodes( 'xs:extra' )->get_node( 1 ) ) || die( 'Frammento non ben formato' );

    my $extra = $parser->parse_balanced_chunk( "<extra>$extra</extra>" );
    $song->appendChild( $extra );
}

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => "r.cgi?section=artist&amp;id=$idArtist&amp;mode=edit" );

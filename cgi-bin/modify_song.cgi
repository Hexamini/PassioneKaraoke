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

print $cgi->header();

my $idArtist = $cgi->param( 'idArtist' );
my $idAlbum = $cgi->param( 'idAlbum' );
my $idSong = $cgi->parama( 'idSong' );
my $name = $cgi->param( 'nameSong' );
my $lirycs = $cgi->param( 'lirycsSong' );
my $extra = $cgi->param( 'extraSong' );
my $category = $cgi->param( 'categorySong' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $song = $doc->findnodes( "\\xs:artist[\@id='$idArtist']\xs:album[\@id='$idAlbum']\xs:song[\@id='$idSong']" );

if( $name )
{
    #Aggiorno l'id
    $idSong = '_' . $name;
    $idSong =~ s/\s+//g;
    $idSong = lc $idSong;

    $song->setAttribute( 'id', $idSong );
    
    my $nodeName = $song->( 'xs:name\text()' )->get_node( 1 );
    $nodeName->setData( $name );
}

if( $lirycs )
{
    my $nodeLirycs = $song->( 'xs:lirycs\text()' )->get_node( 1 );
    $nodeLirycs->setData( $lirycs );
}

if( $extra )
{
    my $nodeExtra = $song->( 'xs:extra\text()' )->get_node( 1 );
    $nodeExtra->setData( $extra );
}

if( $category )
{
    my $nodeCategory = $song->( 'xs:category\text()' )->get_node( 1 );
    $nodeCategory->setData( $category );
}

use lib "cgi-bin";
use strict;

use Page::Object::SongDescription;
use Page::Object::Base::ParserXML;

package SongDescriptionPage;

my $file = '../data/database/news.xml'; 

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id_artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_album ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_song ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $node = $doc->findnodes( "//xs:artist[\@id=$id_artist]" ); #nodo artista
    my $nameArtist = $nodeArtist->findnodes( '/xs:nick' )->get_node( 1 )->textContent;

    $node = $node->findnodes( "/xs:album[\@id=$id_album]" )->get_node( 1 ); #nodo album
    my $nameAlbum = $node->findnodes( '/xs:name' )->get_node( 1 )->textContent;

    $node = $node->findnodes( "/xs:song[\@id=$id_song]" )->get_node( 1 ); #nodo song

    my $nameSong = $node->findnodes( '/xs:name' )->get_node( 1 )->textContent;
    my $lyrics = $node->findnodes( '/xs:lyrics' )->get_node( 1 )->textContent;
    my $extra = $node->findnodes( '/xs:extra' )->get_node( 1 )->textContent;
    
    return SongDescription::get( $nameSong, $nameArtist, $nameAlbum, '#', $lyrics, $extra );
}

1;

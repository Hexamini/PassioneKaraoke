use lib "cgi-bin";
use strict;

use Page::Object::SongDescription;
use Page::Object::Base::ParserXML;

package SongDescriptionPage;

my $file = '../data/database/artistlist.xml'; 

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id_artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_album ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_song ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $node = $doc->findnodes( "//xs:artist[\@id='$id_artist']" )->get_node( 1 ); #nodo artist
    my $nameArtist = $node->findnodes( 'xs:nick/text()' );

    $node = $node->findnodes( "xs:album[\@id='$id_album']" )->get_node( 1 ); #nodo album
    my $nameAlbum = $node->findnodes( 'xs:name/text()' );

    $node = $node->findnodes( "xs:song[\@id='$id_song']" )->get_node( 1 ); #nodo song

    my $nameSong = $node->findnodes( 'xs:name/text()' );
    my $lyrics = $node->findnodes( 'xs:lyrics/text()' );
    my $extra = $node->findnodes( 'xs:extra/text()' );
    
    return SongDescription::get( $nameSong, $nameArtist, $id_artist, $nameAlbum, '#', $lyrics, $extra );
}

1;

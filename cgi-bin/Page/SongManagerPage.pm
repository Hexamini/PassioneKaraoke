use lib "cgi-bin";
use strict;

use Page::Object::SongManager;

package SongManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my ( $artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idArtist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pairs ) =~ /=(.+)/ );

    print "Query string: $artist $idArtist $idAlbum";
    
    return SongManager::get( $idArtist, $artist, $idAlbum );
}

1;

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
    
    return SongManager::get( $idArtist, $artist, $idAlbum );
}

1;

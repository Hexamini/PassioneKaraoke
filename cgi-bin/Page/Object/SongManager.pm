use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package SongManager;

my $struct = 'songManager';

=Description
Paramentri:
    idArtist = Id dell'artista proprietario dell'album
    artist = Nome dell'artista proprietario dell'album
    idAlbum = Id dell'album dove inserire la canzone
=cut
sub get
{
    my ( $idArtist, $artist, $idAlbum ) = @_;

    my $values = {
	'idAritst' => $idArtist,
	'idAlbum' => $idAlbum,
	'artist' => $artist,
    };

    return Behavior::getChain( $struct, $values, 0 );
}

1;

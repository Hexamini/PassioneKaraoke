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
    boxError = Oggetto rappresentavio il riquadro degli errori commessi
=cut
sub get
{
    my ( $idArtist, $artist, $idAlbum, $idSong, $title, $lyrics, $extra, $mode, $boxError ) = @_;

    my $values = {
	'idArtist' => $idArtist,
	'idAlbum' => $idAlbum,
	'idSong' => $idSong,
	'artist' => $artist,
	'title' => $title,
	'lyrics' => $lyrics,
	'extra' => $extra,
	'mode' => $mode,
    };

    if ( defined $boxError ) {
	$values = Behavior::weld( $values, $boxError );
    }
    
    return Behavior::getChain( $struct, $values, 0 );
}

1;

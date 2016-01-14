use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LikeSong;

my $struct = 'likeSong';

=Description
Parametri:
    idArtist = Id dell'artista
    idAlbum = Id dell'album
    idSong = Id della canzone
    songTitle = Titolo della canzone
    artist = Nick dell'artista
=cut
sub get {
    my ( $idArtist, $idAlbum, $idSong, $songTitle, $artist ) = @_;

    my $values = {
	'id_artist' => $idArtist,
	'id_album' => $idAlbum,
	'id_song' => $idSong,
	'songTitle' => $songTitle,
	'artist' => $artist,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

=Description
Paramentri:
    likeSong = Oggetto likeSong da estrarre il contenuto
=cut
sub extractContent {
    my ( $likeSong ) = @_;
    return $likeSong->{ $struct };
}

1;

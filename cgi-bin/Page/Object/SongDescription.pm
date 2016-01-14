use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package SongDescription;

my $struct = 'songDescription';

=Description
Parametri:
    song = Nome canzone
    artist = Nome cantante
    idArtist = Id dell'artista
    album = Nome album
    songDescription = Descrizione della canzone ( immagino note storiche o bibliografiche )
    songLyrics = Testo della canzone
    songExtraResources = Risorse extra
=cut
sub get
{
    my ( $song, $artist, $idArtist, $album, $songDescription, $songLyrics, $songExtraResources ) = @_;

    my $values = {
	'song' => $song,
	'artist' => $artist,
	'idArtist' => $idArtist,
	'album' => $album,
	'songDescription' => $songDescription,
	'songLyrics' => $songLyrics,
	'songExtraResources' => $songExtraResources,
    };

    return Behavior::getChain( $struct, $values );
}

1;

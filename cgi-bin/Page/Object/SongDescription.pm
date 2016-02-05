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
    url = Link al video su YouTube
=cut
sub get
{
    my ( $song, $artist, $idArtist, $album, $songLyrics, $url, $evaluate, $songVotes ) = @_;

    my $values = {
	'song' => $song,
	'artist' => $artist,
	'idArtist' => $idArtist,
	'album' => $album,
	'songLyrics' => $songLyrics,
	'url' => $url,
	'evaluate' => $evaluate,
    };

    if ( defined $songVotes ) {
	$values = Behavior::weld( $values, $songVotes );
    }

    return Behavior::getChain( $struct, $values );
}

1;

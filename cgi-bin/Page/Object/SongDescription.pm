use lib 'cgi-bin';
use strict;

use Page::Object::Utility::Behavior;

package SongDescription;

my $struct = 'songDescription';

=Description
Parametri:
    song = Nome canzone
    artist = Nome cantante
    album = Nome album
    songDescription = Descrizione della canzone ( immagino note storiche o bibliografiche )
    songLyrics = Testo della canzone
    songExtraResources = Risorse extra
=cut
sub get
{
    my ( $song, $artist, $album, $songDescription, $songLyrics, $songExtraResources ) = @_;

    my $values = {
	song => $song,
	artisti => $artist,
	album => $album,
	songDescription => $songDescription,
	songLyrics => $songLyrics,
	songExtraResources => $songExtraResources,
    };

    return Behavior::getChain( $struct, $values );
}

1;

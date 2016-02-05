use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LastSong;

my $struct = 'lastSong';

=begin
Parametri:
    songTitle = Titolo canzone
    artist = Autore dell'opera
    id_artist = Id autore dell'opera
    id_album = Id album contenente l'opera
    id_song = Id canzone
=cut
sub get
{
    my ( $songTitle, $artist, $id_artist, $id_album, $id_song ) = @_;

    my $values = {
	'songTitle' => $songTitle,
	'artist' => $artist,
	'id_artist' => $id_artist,
	'id_album' => $id_album,
	'id_song' => $id_song,
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

sub extractContent
{
    my ( $lastSong ) = @_;
    return $lastSong->{ $struct };
}


1;

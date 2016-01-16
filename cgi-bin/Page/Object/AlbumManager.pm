use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package AlbumManager;

my $struct = "albumManager";

=Description
Parametri:
    idArtist = Id dell'artista creatore dell'album
    artist = Nome dell'artista
    boxError = Oggetto rappresentativo il riquadro degli errori commessi
=cut
sub get
{
    my ( $idArtist, $artist, $boxError ) = @_;

    my $values = {
	'idArtist' => $idArtist,
	'artist' => $artist,
	'boxError' => $boxError,
    };

    return Behavior::getChain( $struct, $values );
}

=Description
Parametri:
    list: array contenente gli oggetti rappresentanti un AlbumManagerList
Ritorno:
    ritorna un oggetto optionArtistName, ovvere una lista di cantanti da selezionare 
=cut
sub optionArtists
{
    my ( @list ) = @_;

    my $optionArtistName = ''; 

    for my $item( @list )
    {
	$optionArtistName = $optionArtistName . AlbumManagerList::extractContent( $item );
    }

    return $optionArtistName;
}

1;

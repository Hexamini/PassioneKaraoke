use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ArtistsList;

my $struct = 'artistsList';

=Description
Parametri:
    nome = Nome dell'artista
    idArtista = Id dell'artista
    logoArtista = Path logo dell'artista
=cut
sub get
{
    my ( $nome, $idArtista, $logoArtista ) = @_;

    my $values = {
	'artist' => $nome,
	'id' => $idArtista,
	'artistLogo' => $logoArtista,
    };

    return Behavior::getChain( $struct, $values, 1 );
}


sub extractContent
{
    my ( $itemArtist ) = @_;
    return $itemArtist->{ $struct };
}

1;

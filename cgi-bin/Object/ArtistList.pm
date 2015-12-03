use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package ArtistList;

my $struct = 'artistList';

=Description
Parametri:
    nome = Nome dell'artista
    logoArtista = Path logo dell'artista
=cut
sub get
{
    my ( $nome, $logoArtista ) = @_;

    my $values = {
	artist => $nome,
	artistLogo => $logoArtista,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

1;

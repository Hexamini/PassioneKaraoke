use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

package ArtistsList;

my $struct = 'artistsList';

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


sub extractContent
{
    my ( $itemArtist ) = @_;
    return $itemArtist->{ $struct };
}

1;

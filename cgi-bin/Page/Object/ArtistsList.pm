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
    my ( $nome, $idArtista, $logoArtista, $modifyButton, $removeButton ) = @_;

    my $values = {
	'artist' => $nome,
	'id' => $idArtista,
	'artistLogo' => $logoArtista,
    };

    if ( defined $modifyButton ) {
	$values = Behavior::weld( $values, $modifyButton );
    } if ( defined $removeButton ) {
	$values = Behavior::weld( $values, $removeButton );
    }

    return Behavior::getChain( $struct, $values, 1 );
}


sub extractContent
{
    my ( $itemArtist ) = @_;
    return $itemArtist->{ $struct };
}

1;

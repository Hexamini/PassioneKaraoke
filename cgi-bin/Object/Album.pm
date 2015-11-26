use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Table;

my $struct = "album";

=begin
Ritorna il codice della tabella in formato HTML
Parametri
    nome: Nome dell'album
    path: path immagine album
    listaCanzoni: rappresentazione della lista di canzoni
=cut
sub get
{
    my( $name, $path, $list ) = @_;

    my $values = {
	nomeAlbum => $name,
	pathAlbum => $path,
	listaCanzoni => $list,
    };
    
    return Behavior::getChain( $stuct, $values, 1 );
}


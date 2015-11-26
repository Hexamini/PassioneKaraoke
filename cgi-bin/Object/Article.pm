use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Article;

=begin
Parametri:
    titolo = Titolo dell'articolo
    sottoTitolo = Sottotitolo dell'articolo
    artista = Nome artista o gruppo
    contenuto = Contenuto dell'articolo    
=cut

sub get
{
    my ( $titolo, $sottoTitolo, $artista, $contenuto ) = @_;

    my $values = {
	artist => $artista
    };
	
}

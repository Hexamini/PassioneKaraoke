use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Article;

my $struct = 'article';

=begin
Parametri:
    titolo = Titolo dell'articolo
    sottoTitolo = Sottotitolo dell'articolo
    autore = Nome autore della notizia
    date = Data di stesura dell'articolo 
    contenuto = Contenuto dell'articolo    
=cut
sub get
{
    my ( $titolo, $sottoTitolo, $autore, $data, $contenuto ) = @_;

    my $values = {
	title => $titolo,
	subtitle => $sottoTitolo,
	author => $autore,
	date => $data,
	content => $contenuto,
    };
	
    return Behavior::getChain( $struct, $values, 1 );
}

1;

use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package SearchResult;

my $struct = 'searchResult';

=Description
Parametri:
    resultLink = Link alla risorsa che soddisfa i criteri di ricerca
    title = Titolo della pagina
    shortDescription = Descrizione breve della pagina cercata
=cut
sub get
{
    my ( $resultLink, $title, $shortDescription ) = @_;
    
    my $values = {
	'resultLink' => $resultLink,
	'title' => $title,
	'shortDescription' => $shortDescription,
    };

    return Behavior::getChain( $struct, $values, 1 );
}


sub extractContent
{
    my ( $result ) = @_;
    return $result->{ $struct };
}

1;

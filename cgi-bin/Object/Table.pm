use lib "cgi-bin";
use strict;

use Object::Utility::ParserHTML;

package Table;

my $struct = "table";

=begin
Ritorna il codice della tabella in formato HTML
Parametri
-hash con le seguenti key: nome, cognome, data, numero
=cut
sub get
{
    my ( $args ) = @_;
        
    my $tmp = ParserHTML::parsing( { filename => $struct, values => $args, } );
    my $chain = ParserHTML::ringChain( $tmp );

    # associa al contenuto una chiave intitolata come la stuttura 
    $chain->{ $struct } = delete $chain->{ 'content' };

    return $chain;
}

1;

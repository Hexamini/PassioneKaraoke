use lib "cgi-bin";
use strict;

use Object::Utility::ParserHTML;

package Table;

=begin
Ritorna il codice della tabella in formato HTML
Parametri
-hash con le seguenti key: nome, cognome, data, numero
=cut
sub getHTML
{
    my ( $args ) = @_;
    my $struct = "table.html";
    
    my $tmp = ParserHTML::parsing( { filename => $struct, values => $args, } );
    my %chain = ParserHTML::ringChain( $tmp );

    return $chain{ '@content' };
}

1;

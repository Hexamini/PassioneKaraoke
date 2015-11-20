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
    my $struct = "table.html";
    my ( $args ) = @_;
    
    return ParserHTML::parsing( { filename => $struct, values => $args, } );
}

1;

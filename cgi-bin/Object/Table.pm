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
    my $struct = "data/table.html";

    my %values;
    $values{'nome'} = $_[0];
    $values{'cognome'} = $_[1];
    $values{'data'} = $_[2];
    $values{'numero'} = $_[3];
    
    return ParserHTML::parsing( $struct, %values );
}

1;

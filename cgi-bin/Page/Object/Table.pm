use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Table;

my $struct = "table";

=begin
Ritorna il codice della tabella in formato HTML
Parametri
-hash con le seguenti key: nome, cognome, data, numero
=cut
sub get
{
    my ( $name, $surname, $data, $number ) = @_;

    my $values = {
	nome => $name,
	cognome => $surname,
	data => $data,
	numero => $number,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

1;

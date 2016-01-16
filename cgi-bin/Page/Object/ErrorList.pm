use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ErrorList;

my $struct = "errorList";

=Description
Parametri:
    error = Descrizione errore
=cut
sub get {
    my ( $error ) = @_;

    my $values = {
	'error' => $error,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent {
    my ( $item ) = @_;
    return $item->{ $struct };
}

    

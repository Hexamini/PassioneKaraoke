use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ErrorList;

my $struct = 'errorList';

=Description
Parametri:
    error = Teste dell'errore
=cut
sub get {
    my ( $error, $idInput ) = @_;

    my $values = {
	'error' => $error,
	'idInput' => $idInput,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent{
    my ( $error ) = @_;
    return $error->{ $struct };
}

1;

use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package ArtistManager;

my $struct = 'artistManager';

=Description
Parametri: 
    boxError = Oggetto rappresentativo il box d'errore
=cut
sub get
{
    my ( $boxError ) = @_;

    my $values = {
	'boxError' => $boxError,
    };
    
    return Behavior::getChain( $struct, $values );
}

1;

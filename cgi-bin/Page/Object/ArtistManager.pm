use lib 'cgi-bin';
use strict;

use Page::Object::Utility::Behavior;

package ArtistManager;

my $struct = 'artistManager';

=Description
Parametri: 
    actionType = Tipologia d'azione in corso. Puo' essere 'Edit' o 'Insert'
=cut
sub get
{
    my ( $actionType ) = @_;

    my $values = {
	actionType => $actionType,
    };
    
    return Behavior::getChain( $struct, $values, 1 );
}

1;

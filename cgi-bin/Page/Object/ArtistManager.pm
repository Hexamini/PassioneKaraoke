use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package ArtistManager;

my $struct = 'artistManager';

=Description
Parametri: 
    actionType = Tipologia d'azione in corso. Puo' essere 'Edit' o 'Insert'
    content = 1 se vuole solo il contenuto, 0 anche i meta associati
=cut
sub get
{
    my ( $actionType, $content ) = @_;

    my $values = {
	'actionType' => $actionType,
    };
    
    return Behavior::getChain( $struct, $values, $content );
}

1;

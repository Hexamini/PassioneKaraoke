use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package SongManager;

my $struct = 'songManager';

=Description
    actionType = Azione da intraprendere, puo' essere Edit o Insert
    content = Valore 1 se si desidera avere solo il contenuto, 0 per i meta
              associati.
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

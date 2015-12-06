use lib 'cgi-bin';
use strict;

use Page::Object::Utility::Behavior;

package SongManager;

my $struct = 'songManager';

=Description
    actionType = Azione da intraprendere, puo' essere Edit o Insert
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

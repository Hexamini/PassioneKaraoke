use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package AdminTools;

my $struct = 'adminTools';

=Description
Parametri:
    articleManager = Gestore articoli
    artistManager = Gestore artitist
    albumManager = Gestore album
=cut
sub get
{
    my ( $articleManager, $artistManager, $albumManager ) = @_;
    
    my $int = Behavior::weld( $articleManager, $artistManager );
    my $values = Behavior::weld( $int, $albumManager );

    return Behavior::getChain( $struct, $values, 1 );
}

1;

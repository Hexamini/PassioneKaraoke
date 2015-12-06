use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

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
    
    my $tmp = Behavior::weld( $articleManager, $artistManager );
    my $values = Behavior::weld( $tmp, $albumManager );

    return Behavior::getChain( $struct, $values, 1 );
}

1;

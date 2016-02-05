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
    songManager = Gestore canzoni
    categoryManager = Gestore categorie
=cut
sub get
{
    my ( $articleManager, $artistManager, $albumManager, $songManager, $categoryManager ) = @_;
    
    my $tmp = Behavior::weld( $articleManager, $artistManager );
    $tmp = Behavior::weld( $tmp, $albumManager );
    $tmp = Behavior::weld( $tmp, $songManager );
    my $values = Behavior::weld( $tmp, $categoryManager );

    return Behavior::getChain( $struct, $values, 1 );
}

1;

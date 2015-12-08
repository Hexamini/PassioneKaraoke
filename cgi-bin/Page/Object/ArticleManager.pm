use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ArticleManager;

my $struct = 'articleManager';

=Description
Parametri:
    content = 1 se si vuole solo il contenuto, 0 anche per i meta associati
=cut
sub get
{
    my ( $content ) = @_;
    return Behavior::getChain( $struct, {}, $content );
}

1;

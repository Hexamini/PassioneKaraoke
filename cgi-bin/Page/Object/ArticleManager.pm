use lib "cgi-bin";
use strict;

use Page::Object::BoxError;
use Page::Object::Base::Behavior;

package ArticleManager;

my $struct = 'articleManager';

=Description
Parametri:
    boxError = Oggetto rappresentante il riquadro degli errori commessi
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

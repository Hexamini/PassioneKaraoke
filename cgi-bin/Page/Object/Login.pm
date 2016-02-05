use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Login;

my $struct = 'login';

sub get
{
    my ( $status ) = @_;
    
    my $values = {
	'visible' => $status,
    };
    
    return Behavior::getChain( $struct, $values );
}

1;

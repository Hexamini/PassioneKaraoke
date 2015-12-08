use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Login;

my $struct = 'login';

sub get
{
    return Behavior::getChain( $struct );
}

1;

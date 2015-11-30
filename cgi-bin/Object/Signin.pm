use lib 'cgi-bin';
use strict;

use Object::Utility::Behavior;

package Signin;

my $struct = 'signin';

sub get
{
    return Behavior::getChain( $struct );
}

1;

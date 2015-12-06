use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package Signin;

my $struct = 'signin';

sub get
{
    return Behavior::getChain( $struct );
}

1;

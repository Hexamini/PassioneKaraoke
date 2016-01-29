use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Message;

my $struct = 'message';

sub get{
    return Behavior::getChain( $struct, {}, 1 );
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package C404;

my $struct = '404';

sub get
{
    return Behavior::getChain( $struct );
}

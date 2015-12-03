use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package ArticleManager;

my $struct = 'articleManager';

sub get
{
    return Behavior::getChain( $struct, {}, 1 );
}

1;

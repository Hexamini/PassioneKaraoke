use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ArticleManager;

my $struct = 'articleManager';

sub get
{
    return Behavior::getChain( $struct );
}

1;

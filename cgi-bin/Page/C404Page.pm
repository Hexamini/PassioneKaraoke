use lib "cgi-bin";
use strict;

use Page::Object::C404;

package C404Page;

sub get
{
    return C404::get();
}

1;

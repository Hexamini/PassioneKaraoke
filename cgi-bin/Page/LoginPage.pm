use lib "cgi-bin";
use strict;

use Page::Object::Login;

package LoginPage;

sub get
{
    return Login::get();
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::Signin;

package SigninPage;

sub get
{
    return Signin::get();
}

1;

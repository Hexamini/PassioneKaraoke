use lib "cgi-bin";
use strict;
use warnings;
use CGI;

package Error;

sub r404 {
    my $cgi = new CGI;
    print $cgi->redirect( -uri => 'r.cgi?' );
}

1;

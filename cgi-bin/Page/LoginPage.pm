use lib "cgi-bin";
use strict;

use Page::Object::Login;

package LoginPage;

sub get
{
    my ( @pairs ) = @_;

    my ( $status ) = ( ( shift @pairs ) =~ /=(.*)/ );
    
    if ( $status eq 'error' ) {
	return Login::get( 'visible' );
    } else {
	return Login::get();
    }
}

1;

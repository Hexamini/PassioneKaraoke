use lib "cgi-bin";
use strict;
use CGI;
use CGI::Session;

package Session;

sub getSession
{
    my $cgi = new CGI;
    my $sid = $cgi->cookie( 'CGISESSID' );

    if( $sid )
    {
	my $session = new CGI::Session( undef, $sid, { Directory => '/tmp/pgnac' } );
    
	if( $session->is_expired || $session->is_empty )
	{
	    return 'Non valido';
	}
	else
	{
	    return $session->param( 'user' );
	}
    }

    else 
    {
	return 'Non valido';
    }
}

1;

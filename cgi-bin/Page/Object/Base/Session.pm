use lib "cgi-bin";
use strict;
use CGI;
use CGI::Session;

use Page::Object::Base::ParserXML;

package Session;

sub getSession
{
    my $cgi = new CGI;
    my $sid = $cgi->cookie( 'CGISESSID' );

    if( $sid )
    {
	my $session = new CGI::Session( undef, $sid, { Directory => '../data/pgnac' } );
    
	if( $session->is_expired || $session->is_empty )
	{
	    return undef;
	}
	else
	{
	    return $session->param( 'user' );
	}
    }

    else 
    {
	return undef;
    }
}

=Description
Paramentri:
    $user = Sessione utente
=cut
sub isAdmin
{
    my ( $user, $parser ) = @_;

    if ( length $user == 0 ) {
	return 0;
    } else {
        my $file = '../data/database/userlist.xml';
	my $doc = ParserXML::getDoc( $parser, $file );

	return $doc->exists( 
	    "//xs:user[\@username='$user' and xs:type='administrator']"
	);
    }
}

1;

use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package UserPage;

my $struct = 'userPage';

=Description
Paramtri:
    username = Nickname di registrazione dell'utente
    adminTools [ opzionale ] = Sezione amministrazione
=cut
sub get
{
    my ( $username, $adminTools ) = @_;

    my $fus = {
	username => $username,
    };

    if( defined $adminTools )
    {
	$fus{ adminTools } = $adminTools->{ AdminTools::structName() };
    }

    return Behavior::getChain( $struct, $values );
}

1;

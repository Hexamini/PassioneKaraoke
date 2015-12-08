use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

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
	'username' => $username,
    };

    if( defined $adminTools )
    {
	$fus = Behavior::weld( $fus, $adminTools );
    }

    return Behavior::getChain( $struct, $fus );
}

1;

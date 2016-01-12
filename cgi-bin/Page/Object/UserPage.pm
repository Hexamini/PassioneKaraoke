use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package UserPage;

my $struct = 'userPage';

=Description
Paramtri:
    username = Nickname di registrazione dell'utente
=cut
sub get
{
    my ( $username ) = @_;

    my $fus = {
	'username' => $username,
    };

    return Behavior::getChain( $struct, $fus );
}

1;

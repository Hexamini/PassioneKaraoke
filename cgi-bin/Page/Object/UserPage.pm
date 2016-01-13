use lib "cgi-bin";
use strict;

use Page::Object::LikeSong;
use Page::Object::Base::Behavior;

package UserPage;

my $struct = 'userPage';

=Description
Paramtri:
    username = Nickname di registrazione dell'utente
    likeSongs = Lista di tutte le canzoni selezionate positivamente dall'utente
=cut
sub get
{
    my ( $username, $likeSongs ) = @_;

    my $fus = {
	'username' => $username,
	'likeSong' => $likeSongs,
    };

    return Behavior::getChain( $struct, $fus );
}

sub likeSong {
    my ( @songs ) = @_;
    my $list = '';

    foreach my $song( @songs ) {
	$list = $list . LikeSong::extractContent( $song );
    }

    return $list;
}

1;

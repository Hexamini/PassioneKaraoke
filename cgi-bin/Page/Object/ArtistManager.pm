use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;

package ArtistManager;

my $struct = 'artistManager';

=Description
Parametri: 
    boxError = Oggetto rappresentativo il box d'errore
=cut
sub get
{
    my ( $idArtist, $nick, $image, $description, $mode, $boxError ) = @_;

    my $values = {
	'id' => $idArtist,
	'nick' => $nick,
	'image' => $image,
	'description' => $description,
	'mode' => $mode,
    };

    if ( defined $boxError ) {
	$values = Behavior::weld( $values, $boxError );
    }
    
    return Behavior::getChain( $struct, $values );
}

1;

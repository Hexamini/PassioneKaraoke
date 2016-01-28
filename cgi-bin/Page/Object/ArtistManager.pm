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
    my ( $nick, $born, $death, $image, $description, $boxError ) = @_;

    my $values = {
	'nick' => $nick,
	'born' => $born,
	'death' => $death,
	'image' => $image,
	'description' => $description,
    };

    if ( defined $boxError ) {
	$values = Behavior::weld( $values, $boxError );
    }
    
    return Behavior::getChain( $struct, $values );
}

1;

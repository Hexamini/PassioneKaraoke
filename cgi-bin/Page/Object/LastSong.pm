use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LastSong;

my $struct = 'lastSong';

=begin
Parametri:
    songTitle = Titolo canzone
    shortText = Descrizione
=cut
sub get
{
    my ( $songTitle, $shortText ) = @_;

    my $values = {
	'songTitle' => $songTitle,
	'shortText' => $shortText,
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

1;

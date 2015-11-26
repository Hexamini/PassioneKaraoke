use lib "cgi-bin";
use strict;

use Object::Utitility::Bahavior;

package Song;

my $struct = 'song';

=begin
Parametri:
    songName = Nome canzone
=cut
sub get
{
    my ( $songName ) = @_;

    my $values = {
	songName => $songName,
    };

    return Bahavior::getChain( $struct, $values, 1 );
}    

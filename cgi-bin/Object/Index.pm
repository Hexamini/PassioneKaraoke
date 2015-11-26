use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Index;

my $struct = 'index';

=begin
Parametri:
    musicCategory = Categoria musica
    lastNews = Rappresentazione delle notize di rilievo
=cut
sub get
{
    my ( $musicCategory, $lastNews ) = @_;

    my $values = {
	musicCategory => $musicCategory,
	lastNews => $lastNews,
    };

    return Behind::getChain( $struct, $values );
}

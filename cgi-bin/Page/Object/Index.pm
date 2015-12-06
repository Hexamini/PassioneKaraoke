use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

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

    my $fus = Behavior::weld( $musicCategory, $lastNews );
    return Behavior::getChain( $struct, $fus );
}

1;

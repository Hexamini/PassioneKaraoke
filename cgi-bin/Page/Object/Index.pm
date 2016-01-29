use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Index;

my $struct = 'index';

=begin
Parametri:
    musicCategory = Categoria musica
    lastNews = Rappresentazione delle notize di rilievo
=cut
sub get
{
    my ( $lastNews ) = @_;

    return Behavior::getChain( $struct, $lastNews );
}

1;

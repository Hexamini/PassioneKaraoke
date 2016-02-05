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
    my ( $lastNews, $message ) = @_;

    my $values = $lastNews;

    if ( defined $message ) {
	$values = Behavior::weld( $values, $message );
    }

    return Behavior::getChain( $struct, $values );
}

1;



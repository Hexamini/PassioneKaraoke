use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Category;

my $struct = 'category';

=begin
    Parametri:
    category = Nome categoria
=cut
sub get
{
    my ( $category ) = @_;

    my $values = {
	category => $values;
    };

    return Behavior::getChain( $struct, $values, 1 );
}

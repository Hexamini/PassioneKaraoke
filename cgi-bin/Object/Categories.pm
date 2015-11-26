use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Categories;

my $struct = 'categories';

=begin
Parametri:
    listOfCategory = Rappresentazione della lista di categorie
=cut

sub Categories
{
    my ( $list ) = @_;

    my $values = {
	listOfCategory => $list,
    };

    return Behavior::getChain( $struct, $values, 1 );   
}

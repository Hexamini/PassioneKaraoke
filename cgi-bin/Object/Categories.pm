use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;
use Object::Category;

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

=Description
Parametri:
    categories = array contenente i nome delle categorie
=cut
sub listCategory
{
    my ( @categories ) = @_;
    my $list = '';

    for my $name( @categories )
    {
	my $category = Category::get( $name );
	$list = $list . $category->{ Category::structName() };
    }

    return $list;
}

1;

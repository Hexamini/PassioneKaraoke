use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;
use Page::Object::Category;

package Categories;

my $struct = 'categories';

=begin
Parametri:
    category = Rappresentazione della lista di categorie
=cut

sub get
{
    my ( $list ) = @_;

    my $values = {
	'category' => $list,
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
	$list = $list . Category::extractContent( $category );
    }

    return $list;
}

1;

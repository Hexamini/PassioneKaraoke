use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

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
	'category' => $category,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent
{
    my ( $category ) = @_;
    return $category->{ $struct };
}

1;

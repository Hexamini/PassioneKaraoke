use lib "cgi-bin";
use strict;
use warnings;

use Page::Object::MapParent;
use Page::Object::Base::Behavior;

package Map;

my $struct = 'map';

sub get{
    my ( $mapParent ) = @_;

    my $values = {
	'mapParent' => $mapParent,
    };

    return Behavior::getChain( $struct, $values );
}    

sub mapParent {
    my ( @items ) = @_;

    my $list = '';

    foreach my $parent( @items ) {
	$list = $list . MapParent::extractContent( $parent );
    }

    return $list;
}

1;

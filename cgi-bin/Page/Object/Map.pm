use lib "cgi-bin";
use strict;
use warnings;

use Page::Object::MapParent;
use Page::Object::Base::Behavior;

package Map;

my $struct = 'map';

sub get{
    my ( $mapParent ) = @_;

    return Behavior::getChain( $struct, $mapParent );
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

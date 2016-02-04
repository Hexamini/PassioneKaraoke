use lib "cgi-bin";
use strict;
use warnings;

use Page::Object::MapList;
use Page::Object::Base::Behavior;

package MapParent;

my $struct = 'mapParent';

sub get{
    my ( $link, $mapList ) = @_;
    my $values = Behavior::weld( $link, $mapList );

    return Behavior::getChain( $struct, $values, 1 );
}

sub mapList{
    my ( @items ) = @_;
    my $list = '';

    foreach my $children( @items ) {
	$list = $list . MapList::extractContent( $children );
    }

    return $list;
}

sub extractContent{
    my ( $mapParent ) = @_;
    return $mapList->{ $struct };
}

1;

use lib "cgi-bin";
use strict;
use warnings;

use Page::Object::Base::Behavior;

package MapList;

my $struct = "mapList";

sub get {
    my ( $link ) = @_;

    return Behavior::getChain( $struct, $link, 1 );
}

sub extractContent{
    my ( $mapList ) = @_;
    return $mapList->{$struct};
}

1;

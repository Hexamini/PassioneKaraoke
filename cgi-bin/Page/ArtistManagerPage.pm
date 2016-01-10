use lib "cgi-bin";
use strict;

use Page::Object::ArtistManager;

package ArtistManagerPage;

sub get
{
    my ( @pairs ) = @_;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    return ArtistManager::get( $mode, 0 );
}

1;

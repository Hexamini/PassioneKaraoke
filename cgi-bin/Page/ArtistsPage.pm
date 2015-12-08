use lib "cgi-bin";
use strict;

use Page::Object::Artists;
use Page::Object::ArtistsList;

package ArtistsPage;

sub get
{
    my $artist1 = ArtistsList::get( "Gioban", "#" );
    my $artist2 = ArtistsList::get( "Vio", "#" );

    my @artists = ( $artist1, $artist2 );
    return Artists::get( Artists::artistsList( @artists ) );
}

1;

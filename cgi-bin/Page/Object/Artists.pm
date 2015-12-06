use lib 'cgi-bin';
use strict;

use Page::Object::Utility::Behavior;
use Page::Object::ArtistsList;

package Artists;

my $struct = 'artists';

=Description
Parametri:
    listArtists = Oggetto rappresentativo la lista degli artisti
=cut
sub get
{
    my ( $listOfArtists ) = @_;
    
    my $values = {
	listOfArtists => $listOfArtists,
    };
    
    return Behavior::getChain( $struct, $values );
}


=Description
Parametri:
    artists = Array di Artist
=cut
sub artistsList
{
    my ( @artists ) = @_;
    
    my $list = '';

    for my $artist( @artists )
    {
	$list = $list . ArtistsList::extractContent( $artist );
    }

    return $list;
}

1;

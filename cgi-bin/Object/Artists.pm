use lib 'cgi-bin';
use strict;

use Object::Utility::Behavior;
use Object::ArtistsList;

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
	$list = $list . $artist->{ ArtistsList::structName() };
    }

    return $list;
}

1;

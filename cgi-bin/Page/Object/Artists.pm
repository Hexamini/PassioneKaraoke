use lib 'cgi-bin';
use strict;

use Page::Object::Base::Behavior;
use Page::Object::ArtistsList;

package Artists;

my $struct = 'artists';

=Description
Parametri:
    listArtists = Oggetto rappresentativo la lista degli artisti
    editButton = Oggetto rappresentante un bottone per accedere alla modalita
                 edit
    artistManager = Oggetto rappresentate la gestione di un artita
=cut
sub get
{
    my ( $listOfArtists, $editButton, $artistManager ) = @_;

    my $values = {
	'listOfArtists' => $listOfArtists,
    };

    if ( defined $editButton ) {
	$values = Behavior::weld( $values, $editButton );
    }

    if ( defined $artistManager ) {
	$values = Behavior::weld( $values, $artistManager );
    }
    
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

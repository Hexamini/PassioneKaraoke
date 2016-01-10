use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package AlbumManager;

my $struct = "albumManager";

=Description
Parametri:

=cut
sub get
{
    return Behavior::getChain( $struct );
}

=Description
Parametri:
    list: array contenente gli oggetti rappresentanti un AlbumManagerList
Ritorno:
    ritorna un oggetto optionArtistName, ovvere una lista di cantanti da selezionare 
=cut
sub optionArtists
{
    my ( @list ) = @_;

    my $optionArtistName = ''; 

    for my $item( @list )
    {
	$optionArtistName = $optionArtistName . AlbumManagerList::extractContent( $item );
    }

    return $optionArtistName;
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;
use Page::Object::AlbumManagerList;

package AlbumManager;

my $struct = "albumManager";

=Description
Parametri:
    actionType = Modalita' inserimento, puo' assumere valore 'Edit' o 'Insert'
    optionArtistName = Lista cantanti compositori dell'album
=cut
sub get
{
    my ( $actionType, $optionArtistName ) = @_;

    my $values = {
	'actionType' => $actionType,
	'optionArtistName' => $optionArtistName,
    };
    
    return Behavior::getChain( $struct, $values );
}

=Description
Parametri:
    artists: array contenente i nomi degli artisti
Ritorno:
    ritorna un oggetto optionArtistName, ovvere una lista di cantanti da selezionare 
=cut
sub optionArtists
{
    my ( @artists ) = @_;

    my $optionArtistName = ''; 

    for my $name( @artists )
    {
	my $opt = AlbumManagerList::get( $name );
	$optionArtistName = $optionArtistName . AlbumManagerList::extractContent( $opt );
    }

    return $optionArtistName;
}

1;

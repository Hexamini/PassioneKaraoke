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
    content = Valore 1 se si desidera avere solo il contenuto, 0 per i meta 
              associati.
=cut
sub get
{
    my ( $actionType, $optionArtistName, $content ) = @_;

    my $values = {
	'actionType' => $actionType,
	'optionArtistName' => $optionArtistName,
    };
    
    return Behavior::getChain( $struct, $values, $content );
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

    for my $item( @artists )
    {
	$optionArtistName = $optionArtistName . AlbumManagerList::extractContent( $item );
    }

    return $optionArtistName;
}

1;

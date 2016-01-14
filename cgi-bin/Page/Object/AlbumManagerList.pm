use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package AlbumManagerList;

my $struct = 'albumManagerList';

=Description
Parametri: 
    id = id del cantante
    name = nome del cantante
=cut
sub get
{
    my ( $id, $name ) = @_;

    my $values = {
	'artistId' => $id,
	'artistName' => $name,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent
{
    my ( $itemList ) = @_;
    return $itemList->{ $struct };
}

1;

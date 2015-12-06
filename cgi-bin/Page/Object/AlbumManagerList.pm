use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

package AlbumManagerList;

my $struct = 'albumManagerList';

=Description
Parametri: 
    artistName = nome del cantante
=cut
sub get
{
    my ( $name ) = @_;

    my $values = {
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

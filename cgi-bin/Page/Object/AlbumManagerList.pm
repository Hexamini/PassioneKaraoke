use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

package AlbumManagerList;

my $struct = 'AlbumManagerList';

=Description
Parametri: 
    artistName = nome del cantante
=cut
sub get
{
    my ( $name ) = @_;

    my $values = {
	artistName => $name,
    };

    return Behavior::getChain( $struct, $values, 1 );
}


sub structName
{
    return $struct;
}

1;

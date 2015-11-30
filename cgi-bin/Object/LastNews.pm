use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package LastNews;

my $struct = "lastNews";

=begin

=cut
sub get
{
    my ( $lastSong, $lastArticle ) = @_;

    my $fus = Behavior::weld( $lastSong, $lastArticle );
    return Behavior::getChain( $struct, $fus, 1 );
}

1;

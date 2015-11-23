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
    
    my $values = {
	lastSong => $lastSong,
	lastArticle => $lastArticle,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

1;

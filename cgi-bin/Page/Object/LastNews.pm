use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LastNews;

my $struct = "lastNews";

=begin
Parametri:
    lastSong = Oggetto rappresentativo di LastSong
    lastArticle = Oggetto rappresentativo di LastArticle
=cut
sub get
{
    my ( $lastSong, $lastArticle ) = @_;

    my $fus = Behavior::weld( $lastSong, $lastArticle );
    return Behavior::getChain( $struct, $fus, 1 );
}

1;

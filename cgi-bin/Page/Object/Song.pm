use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

package Song;

my $struct = 'song';

=begin
Parametri:
    songName = Nome canzone
=cut
sub get
{
    my ( $songName ) = @_;

    my $values = {
	'songName' => $songName,
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

sub extractContent
{
    my ( $song ) = @_;
    return $song->{ $struct };
}

1;



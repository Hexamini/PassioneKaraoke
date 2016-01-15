use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Song;

my $struct = 'song';

=begin
Parametri:
    songName = Nome canzone
=cut
sub get
{
    my ( $songName, $artistID, $albumID, $songID ) = @_;

    my $values = {
	'songName' => $songName,
	'artist' => $artistID,
	'album' => $albumID,
	'song' => $songID,
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

sub extractContent
{
    my ( $song ) = @_;
    return $song->{ $struct };
}

1;



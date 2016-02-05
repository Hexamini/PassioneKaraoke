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
    my ( $songName, $artistID, $albumID, $songID, $modifyButton, $removeButton ) = @_;

    my $values = {
	'songName' => $songName,
	'artist' => $artistID,
	'album' => $albumID,
	'song' => $songID,
    };

    if ( defined $modifyButton ) {
	$values = Behavior::weld( $values, $modifyButton );
    } if ( defined $removeButton ) {
	$values = Behavior::weld( $values, $removeButton );
    }

    return Behavior::getChain( $struct, $values, 1 );
}    

sub extractContent
{
    my ( $song ) = @_;
    return $song->{ $struct };
}

1;



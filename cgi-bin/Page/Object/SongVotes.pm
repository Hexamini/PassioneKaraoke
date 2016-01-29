use lib "cgi-bin";
use strict;

use Page::Object::Behavior;

package SongVotes;

my $struct = 'songVotes';

sub get {
    my ( $user, $artist, $album, $song ) = @_;

    my $values = {
	'user' => $user,
	'artist' => $artist,
	'album' => $album,
	'song' => $song,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub messageConfirm {
    return { $struct => 'Hai espresso il tuo voto' }; 
}

1;

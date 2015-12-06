use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;
use Object::Song;

package Album;

my $struct = "album";

=begin
Ritorna il codice della tabella in formato HTML
Parametri
    album = Nome dell'album
    albumName = ???
    albumImage = path immagine album
    songsList = rappresentazione della lista di canzoni
=cut
sub get
{
    my( $album, $albumName, $albumImage, $songsList ) = @_;

    my $values = {
	album => $album,
	albumImage => $albumImage,
	albumName => $albumName, 
	songsList => $songsList,
    };
    
    return Behavior::getChain( $stuct, $values, 1 );
}


sub structName
{
    return $struct;
}


sub songsList
{
    my ( @songsName ) = @_;

    my $list = '';

    for my $name( @songsName )
    {
	my $item = Song::get( $name );
	$list = $list . $item->{ Song::structName() };
    }

    return $list;
}

1;

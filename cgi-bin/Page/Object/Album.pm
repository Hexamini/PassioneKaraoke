use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;
use Page::Object::Song;

package Album;

my $struct = "album";

=begin
Ritorna il codice della tabella in formato HTML
Parametri
    album = Nome dell'album
    albumImage = path immagine album
    songsList = rappresentazione della lista di canzoni
=cut
sub get
{
    my( $album, $albumImage, $songsList ) = @_;

    my $values = {
	'album' => $album,
	'albumImage' => $albumImage,
	'songsList' => $songsList,
    };
    
    return Behavior::getChain( $struct, $values, 1 );
}


sub extractContent
{
    my ( $album ) = @_;
    return $album->{ $struct };
}


sub songsList
{
    my ( @songs ) = @_;

    my $list = '';

    for my $song( @songs )
    {
	$list = $list . Song::extractContent( $song );
    }

    return $list;
}

1;

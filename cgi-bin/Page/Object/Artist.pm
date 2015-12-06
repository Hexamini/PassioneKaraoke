use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;
use Page::Object::Album;

package Artist;

my $struct = 'artist';

=begin
Parametri:
    artist = Nome del gruppo o cantante
    pathArtista = Path dell'immagine
    artistBio = Bibliografia del cantante
    albumList = Rappresentazione lista album 
=cut
sub get
{
    my ( $artist, $pathArtista, $artistBio, $albumList ) = @_;

    my $values = {
	'artist' => $artist,
	'pathArtista' => $pathArtista,
	'artistBio' => $artistBio,
	'albumList' => $albumList,
    };

    return Behavior::getChain( $struct, $values );
}

sub listAlbum
{
    my ( @albums ) = @_;

    my $list = '';

    for my $album( @albums )
    {
	$list = $list . Album::extractContent( $album );
    }

    return $list;
}

1;

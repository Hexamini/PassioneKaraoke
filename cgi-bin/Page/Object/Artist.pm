use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;
use Page::Object::Album;

package Artist;

my $struct = 'artist';

=begin
Parametri:
    artist = Nome del gruppo o cantante
    artistPhoto = Nome dell'immagine con il formato
    artistBio = Bibliografia del cantante
    albumList = Rappresentazione lista album 
    editButton = Rappresentazione bottone per l'entrata in edit mode
    addButton = Rappresentazione bottone per l'inserimento di un album
=cut
sub get
{
    my ( $artist, $artistPhoto, $artistBio, $albumList, $editButton, $addButton ) = @_;

    my $values = {
	'artist' => $artist,
	'artistPhoto' => $artistPhoto,
	'artistBio' => $artistBio,
	'albumList' => $albumList,
    };

    if ( defined $editButton ) {
	$values = Behavior::weld( $values, $editButton );
    } 
    
    if ( defined $addButton ) {
	$values = Behavior::weld( $values, $addButton );
    }

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

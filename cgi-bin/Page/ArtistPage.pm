use lib "cgi-bin";
use strict;
use Page::Object::Artist;
use Page::Object::Album;
use Page::Object::Song;

package ArtistPage;

sub get
{
    my @songs = ( 'Ciao', 'Mia', 'Venere' );
    my $songList = Album::songsList( @songs );
    my $album1 = Album::get( 'Ge', '#', $songList );
    my $album2 = Album::get( 'Cing', '#', $songList );
    
    my @albums = ( $album1, $album2 );

    return Artist::get( 'Io', '#', 'Nato a Treviso', Artist::listAlbum( @albums ) ); 
}

1;

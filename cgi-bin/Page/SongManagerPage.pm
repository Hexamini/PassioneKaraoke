use lib "cgi-bin";
use strict;

use Page::Object::BoxError;
use Page::Object::SongManager;

package SongManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my ( $artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idArtist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my @errors = ();

    while ( length @pairs > 0 ) {
	push @errors, ( ( shift @pairs ) =~ /=(.+)/ );
    }

    my $boxError = '';

    if ( length @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }

    return SongManager::get( $idArtist, $artist, $idAlbum, $boxError );
}

1;

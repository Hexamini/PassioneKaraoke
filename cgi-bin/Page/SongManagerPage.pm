use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::SongManager;

package SongManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my ( $artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idArtist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pairs ) > 0 ) {
	#Section catched forms
	( $forms{ 'title' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'lyrics' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'extra' } ) = ( ( shift @pairs ) =~ /=(.+)/ );

	#Section catched errors
	while ( scalar @pairs > 0 ) {
	    push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
	}
    }

    my $boxError = undef;

    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }

    return SongManager::get( 
	$idArtist,
	$artist,
	$idAlbum,
	$forms{ 'title' },
	$forms{ 'lyrics' },
	$forms{ 'extra' },
	$boxError
    );
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::ArtistManager;

package ArtistManagerPage;

sub get
{
    my ( @pairs ) = @_;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my @errors = ();

    #Section catched errors
    while ( ( scalar @pairs ) > 0 ) {
	push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
    }

    my $boxError;
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    my $artistManager = '';

    if ( $mode == 'insert' ) {
	$artistManager = ArtistManager::get( $boxError );
    } else {
	#Da aggiungere la compilazione dei campi in ArtistManager
    }

    return $artistManager;
}

1;

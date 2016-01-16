use lib "cgi-bin";
use strict;

use Page::Object::ArtistManager;

package ArtistManagerPage;

sub get
{
    my ( @pairs ) = @_;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my @errors = ();

    #Section catched errors
    while ( ( length @pairs ) > 0 ) {
	push @errors, ( ( shift @pairs ) =~ /=(.+)/ );
    }

    my $boxError = '';
    
    if ( length @errors > 0 ) {
	$boxError = BoxError::get( BoxError::ErrorList( @errors ) );
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

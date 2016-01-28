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

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pairs ) > 0 ) {
	#Section catched forms
	( $forms{ 'nick' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'birthday' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'dead' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'image' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'description' } ) = ( ( shift @pairs ) =~ /=(.+)/ );

        #Section catched errors
	while ( ( scalar @pairs ) > 0 ) {
	    push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
	}
    }

    my $boxError = undef;
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    my $artistManager = '';

    if ( $mode == 'insert' ) {
	$artistManager = ArtistManager::get( 
	    $forms{ 'nick' },
	    $forms{ 'birthday' },
	    $forms{ 'dead' },
	    $forms{ 'image' },
	    $forms{ 'description' },
	    $boxError
	);

    } else {
	#Da aggiungere la compilazione dei campi in ArtistManager
    }

    return $artistManager;
}

1;

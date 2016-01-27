use lib "cgi-bin";
use strict;

use Page::Object::ArticleManager;
use Page::Object::ErrorList;
use Page::Object::BoxError;

package ArticleManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pairs ) > 0 ) {
	#Section catched forms
	( $forms{ 'author' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'date' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'title' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'subtitle' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'content' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	
	#Section catched errors
	while ( scalar @pairs > 0 ) {
	    push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
	}
    }

    my $boxError = undef;
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    return ArticleManager::get( 
	$forms{ 'author' },
	$forms{ 'date' },
	$forms{ 'title' },
	$forms{ 'subtitle' },
	$forms{ 'content' },
	$boxError 
    );
}

1;
  

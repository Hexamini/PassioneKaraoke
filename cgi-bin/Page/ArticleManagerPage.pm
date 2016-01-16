use lib "cgi-bin";
use strict;

use Page::Object::ArticleManager;
use Page::Object::ErrorList;
use Page::Object::BoxError;

package ArticleManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my @errors = ();

    while ( scalar @pairs > 0 ) {
	push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
    }

    my $boxError = '';
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    return ArticleManager::get( $boxError );
}

1;
  

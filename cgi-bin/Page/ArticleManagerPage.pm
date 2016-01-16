use lib "cgi-bin";
use strict;

use Page::Object::ArticleManager;
use Page::Object::BoxError;

package ArticleManagerPage;

sub get
{
    my ( @pairs ) = @_;

    my @errors = ();

    while ( length @pairs > 0 ) {
	push @errors, ( ( shift @pairs ) =~ /=(.+)/ );
    }

    my $boxError = '';
    
    if ( length @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    return ArticleManager::get( $boxError );
}

1;
  

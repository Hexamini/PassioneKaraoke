use lib "cgi-bin";
use strict;

use Page::Object::ArticleManager;
use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::Base::ParserXML;

package ArticleManagerPage;

my $file = '../data/database/articlelist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $id ) = ( ( shift @pairs ) =~ /=(.+)/ ); #Potenzialmente vuoto
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );
    
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

    if ( $mode eq 'modify' ) {
	my $doc = ParserXML::getDoc( $parser, $file );

	my $node = $doc->findnodes( "//xs:article[\@id='$id']" )->get_node( 1 );

	if ( !exists $forms{ 'author' } ) {
	    $forms{ 'author' } = $node->findnodes( 'xs:author/text()' );
	} if ( !exists $forms{ 'date' } ) {
	    $forms{ 'date' } = $node->findnodes( 'xs:data/text()' );
	} if ( !exists $forms{ 'title' } ) {
	    $forms{ 'title' } = $node->findnodes( 'xs:title/text()' );
	} if ( !exists $forms{ 'subtitle' } ) {
	    $forms{ 'subtitle' } = $node->findnodes( 'xs:subtitle/text()' );
	} if ( !exists $forms{ 'content' } ) {
	    $forms{ 'content' } = $node->findnodes( 'xs:content/text()' );
	}
    }

    my $boxError = undef;
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    return ArticleManager::get( 
	$id,
	$forms{ 'author' },
	$forms{ 'date' },
	$forms{ 'title' },
	$forms{ 'subtitle' },
	$forms{ 'content' },
	$mode,
	$boxError 
    );
}

1;
  

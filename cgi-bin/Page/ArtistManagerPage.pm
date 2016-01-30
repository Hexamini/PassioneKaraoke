use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::ArtistManager;
use Page::Object::Base::ParserXML;

package ArtistManagerPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $id ) = ( ( shift @pairs ) =~ /=(.+)/ ); #Potenzialmente vuoto
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

    if ( $mode eq 'modify' ) {
	my $doc = ParserXML::getDoc( $parser, $file );

	my $node = $doc->findnodes( "//xs:artist[\@id='$id']" )->get_node( 1 );

	if ( !exists $forms{ 'nick' } ) {
	    $forms{ 'nick' } = $node->findnodes( 'xs:nick/text()' );
	} if ( !exists $forms{ 'birthday' } ) {
	    $forms{ 'birthday' } = $node->findnodes( 'xs:born/text()' );
	} if ( !exists $forms{ 'dead' } ) {
	    #$forms{ 'dead' } = $node->findnodes( 'xs:dead/text()' );
	} if ( !exists $forms{ 'image' } ) {
	    #$forms{ 'image' } = $node->findnodes( 'xs:image/text()' );
	} if ( !exists $forms{ 'description' } ) {
	    $forms{ 'description' } = $node->findnodes( 'xs:description/text()' );
	}
    }
    
    my $boxError = undef;
    
    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }

    return ArtistManager::get( 
	$id,
	$forms{ 'nick' },
	$forms{ 'birthday' },
	$forms{ 'dead' },
	$forms{ 'image' },
	$forms{ 'description' },
	$mode,
	$boxError
    );
}

1;

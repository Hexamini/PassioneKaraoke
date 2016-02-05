use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::AlbumManager;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Check;

package AlbumManagerPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $idArtist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pairs ) =~ /=(.+)/ ); #Potenzialmente vuoto
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pairs ) > 0 ) {
	#Section catcher forms
	$forms{ 'album' } = Check::cleanExpression( ( shift @pairs ) =~ /=(.+)/ );
	$forms{ 'image' } = Check::cleanExpression( ( shift @pairs ) =~ /=(.+)/ );

	while ( scalar @pairs > 0 ) {
	    my $message = Check::cleanExpression( ( shift @pairs ) =~ /=(.+)/ );
	    my ( $input ) = ( ( shift @pairs ) =~ /=(.+)/ );
	    
	    push @errors, ErrorList::get( 
		$message,
		$input
	    );
	}
    }

    if ( $mode eq 'modify' ) {
	my $node = $doc->findnodes(
	    "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']"
	    )->get_node( 1 );

	if ( !exists $forms{ 'album' } ) {
	    $forms{ 'album' } = $node->findnodes( 'xs:name/text()' );
	} if ( !exists $forms{ 'image' } ) {
	    $forms{ 'image' } = $node->findnodes( 'xs:image/text()' );
	}
    }
    
    my $boxError = undef;

    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    my $artist = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:nick/text()" );

    return AlbumManager::get(
	$idArtist,
	$idAlbum,
	$artist,
	$forms{ 'album' },
	$forms{ 'image' },
	$mode,
	$boxError 
    );
}

1;

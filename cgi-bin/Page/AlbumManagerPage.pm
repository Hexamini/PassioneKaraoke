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
    my ( $parser, @pair ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $idArtist ) = ( ( shift @pair ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pair ) =~ /=(.+)/ ); #Potenzialmente vuoto
    my ( $mode ) = ( ( shift @pair ) =~ /=(.+)/ );

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pair ) > 0 ) {
	#Section catcher forms
	$forms{ 'album' } = Check::cleanExpression( ( shift @pair ) =~ /=(.+)/ );
	$forms{ 'image' } = Check::cleanExpression( ( shift @pair ) =~ /=(.+)/ );

	while ( scalar @pair > 0 ) {
	    push @errors, ErrorList::get( 
		Check::cleanExpression( ( shift @pair ) =~ /=(.+)/ ) 
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

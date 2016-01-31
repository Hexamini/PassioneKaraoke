use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::AlbumManager;
use Page::Object::Base::ParserXML;

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
	( $forms{ 'album' } ) = ( ( shift @pair ) =~ /=(.+)/ );
	( $forms{ 'date' } ) = ( ( shift @pair ) =~ /=(.+)/ );

	while ( scalar @pair > 0 ) {
	    push @errors, ErrorList::get( ( ( shift @pair ) =~ /=(.+)/ ) );
	}
    }

    if ( $mode eq 'modify' ) {
	my $node = $doc->findnodes(
	    "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']"
	    )->get_node( 1 );

	if ( !exists $forms{ 'album' } ) {
	    $forms{ 'album' } = $node->findnodes( 'xs:name/text()' );
	} if ( !exists $forms{ 'date' } ) {
	    $forms{ 'date' } = $node->findnodes( 'xs:creation/text()' );
	}
    }
    
    my $boxError = undef;

    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    my $artist = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:nick/text()" );
    my $albumManager = '';

    $albumManager = AlbumManager::get(
	$idArtist,
	$idAlbum,
	$artist,
	$forms{ 'album' },
	$forms{ 'date' },
	$mode,
	$boxError 
	);

    return $albumManager;
}

1;

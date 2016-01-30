use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::BoxError;
use Page::Object::SongManager;
use Page::Object::Base::ParserXML;

package SongManagerPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idArtist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idAlbum ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $idSong ) = ( ( shift @pairs ) =~ /=(.+)/ ); #Potenzialmente vuoto
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my %forms = ();
    my @errors = ();

    if ( ( scalar @pairs ) > 0 ) {
	#Section catched forms
	( $forms{ 'title' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'lyrics' } ) = ( ( shift @pairs ) =~ /=(.+)/ );
	( $forms{ 'extra' } ) = ( ( shift @pairs ) =~ /=(.+)/ );

	#Section catched errors
	while ( scalar @pairs > 0 ) {
	    push @errors, ErrorList::get( ( ( shift @pairs ) =~ /=(.+)/ ) );
	}
    }

    if ( $mode eq 'modify' ) {
	my $doc = ParserXML::getDoc( $parser, $file );

	my $node = $doc->findnodes( 
	    "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']/".
	    "xs:song[\@id='$idSong']"
	)->get_node( 1 );

	
	if ( !exists $forms{ 'title' } ) {
	    $forms{ 'title' } = $node->findnodes( 'xs:name/text()' );	    
	} if ( !exists $forms{ 'lyrics' } ) {
	    $forms{ 'lyrics' } = $node->findnodes( 'xs:lyrics/text()' );
	} if ( !exists $forms{ 'extra' } ) {
	    $forms{ 'extra' } = $node->findnodes( 'xs:extra/text()' );
	}
    }
    
    my $boxError = undef;

    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }

    return SongManager::get( 
	$idArtist,
	$artist,
	$idAlbum,
	$idSong,
	$forms{ 'title' },
	$forms{ 'lyrics' },
	$forms{ 'extra' },
	$mode,
	$boxError
    );
}

1;

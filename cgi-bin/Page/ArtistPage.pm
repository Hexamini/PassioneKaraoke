use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Artist;
use Page::Object::Album;
use Page::Object::Song;
use Page::Object::EditButton;
use Page::Object::AlbumManager;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package ArtistPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $nodo = $doc->findnodes( "//xs:artist[\@id='$id']" )->get_node( 1 );

    my $name = $nodo->findnodes( "xs:nick/text()" );
    my $description = $nodo->findnodes( 'xs:description/text()' );

    my @nodeAlbum = $nodo->findnodes( 'xs:album' );
    my @albums = ();
    
    
    foreach my $album( @nodeAlbum )
    {
	my $nameAlbum = $album->findnodes( 'xs:name/text()' );
	
	my @nodeSong = $album->findnodes( 'xs:song' );
	my @songs = ();
	
	foreach my $song( @nodeSong )
	{
	    push @songs, $song->findnodes( 'xs:name/text()' );
	}

	my $songList = Album::songsList( @songs );
	push @albums, Album::get( $nameAlbum, '#', $songList );
    }

    @albums = reverse @albums;

    my $user = Session::getSession();
    my $artistPage = '';

    if ( !Session::isAdmin( $user ) ) {
	$artistPage = Artist::get( $name, '#', $description, Artist::listAlbum( @albums ) ); 
    } else {
	
	my $size = @pairs;
	my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

	if ( $size == 1 && $mode == 'edit' ) {

	    $artistPage = Artist::get( 
		$name,
		'#',
		$description,
		Artist::listAlbum( @albums ),
		EditButton::get( "section=artist&amp;id=$id", 'edit', 'Sezione Amministrativa', 'editButton' ),
		EditButton::get( "section=albumManager&amp;artist=$id", 'insert', '&#43', 'addButton' )
	    );

 	} else {
	    $artistPage = Artist::get( 
		$name,
		'#',
		$description,
		Artist::listAlbum( @albums ),
		EditButton::get( "section=artist&amp;id=$id", 'edit', 'Sezione Amministrativa', 'editButton' )
	    );
	}
    }
    
    return $artistPage;
}

1;

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

    my ( $id ) = ( ( shift @pairs ) =~ /=(.+)/ ); #id artista
    
    my $size = @pairs;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $editMode = ( $size == 1 && $mode == 'edit' );
    
    my $nodo = $doc->findnodes( "//xs:artist[\@id='$id']" )->get_node( 1 );

    my $name = $nodo->findnodes( "xs:nick/text()" ); #nome artista
    my $description = $nodo->findnodes( 'xs:description/text()' );

    my @nodeAlbum = $nodo->findnodes( 'xs:album' );
    my @albums = ();
    
    
    foreach my $album( @nodeAlbum )
    {
	my $nameAlbum = $album->findnodes( 'xs:name/text()' );
	my $idAlbum = $album->getAttribute( 'id' );
	
	my @nodeSong = $album->findnodes( 'xs:song' );
	my @songs = ();
	
	foreach my $song( @nodeSong )
	{
	    my $idSong = $song->getAttribute( 'id' );
	    my $nameSong = $song->findnodes( 'xs:name/text()' );
	    push @songs, Song::get( $nameSong, $id, $idAlbum, $idSong );
	}

	my $songList = Album::songsList( @songs );
	push @albums, ( $editMode ) ?
	    Album::get( 
		$nameAlbum,
		'#',
		$songList,
		EditButton::get( "r.cgi?section=songManager&artist=$name&amp;" . 
				 "idArtist=$id&amp;album=$idAlbum&amp;mode=insert",
				 '&#43', 'addButton' ),
		EditButton::get( 'modify', '&#45', 'modifyButton' ),
		EditButton::get( 
		    'remove_artist.cgi', 
		    '&#44', 
		    'removeButton'
		)
	    ) :
	    Album::get( $nameAlbum, '#', $songList );
    }

    @albums = reverse @albums;

    my $user = Session::getSession();
    my $artistPage = '';

    if ( !Session::isAdmin( $user ) ) {
	$artistPage = Artist::get( $name, '#', $description, Artist::listAlbum( @albums ) ); 
    } else {
	if ( $editMode ) {

	    $artistPage = Artist::get( 
		$name,
		'#',
		$description,
		Artist::listAlbum( @albums ),
		EditButton::get( 
		    "r.cgi?section=artist&amp;id=$id&amp;mode=edit", 
		    'Sezione Amministrativa', 
		    'editButton'
		),
		EditButton::get( 
		    "r.cgi?section=albumManager&amp;artist=$id&amp;mode=insert", 
		    '&#43', 
		    'addButton'
		)
	    );

 	} else {
	    $artistPage = Artist::get( 
		$name,
		'#',
		$description,
		Artist::listAlbum( @albums ),
		EditButton::get( 
		    "r.cgi?section=artist&amp;id=$id&amp;mode=edit", 
		    'Sezione Amministrativa', 
		    'editButton'
		)
	    );
	}
    }
    
    return $artistPage;
}

1;



use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Artist;
use Page::Object::Album;
use Page::Object::Song;
use Page::Object::Base::ParserXML;

package ArtistPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pair ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id ) = ( ( shift @pair ) =~ /=(.+)/ );

    my $nodo = $doc->findnodes( "//band[\@id=$id]" )->get_node( 1 );
    my $name = '';
    
    if( $nodo ) #band...
    {
	$name = $nodo->findnodes( 'name' )->get_node( 1 )->textContent;
    }
    else #...o singolo
    {
	$name = $doc->findnodes( "//single[\@=$id]/nick" )->get_node( 1 )->textContent;
    }
        
    $nodo = $doc->findnodes( "//*[\@id=$id]" )->get_node( 1 );

    my $description = $doc->findnodes( '/description' )->get_node( 1 )->textContent;
    
    my @nodeAlbum = $doc->findnodes( '/album' );
    my @albums = ();
    
    
    foreach my $album( @nodeAlbum )
    {
	my $nameAlbum = $album->findnodes( '/name' )->get_node( 1 )->textContent;
	
	my @nodeSong = $doc->findnodes( '/song' );
	my @songs = ();
	
	foreach my $song( @nodeSong )
	{
	    push @songs, $song->findnodes( '/name' )->get_node( 1 )->textContent;
	}

	my $songList = Album::songsList( @songs );
	push @albums, Album::get( $nameAlbum, '#', $songList );
    }
    
    return Artist::get( $name, '#', $description, Artist::listAlbum( @albums ) ); 
}

1;

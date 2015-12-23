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
    
    return Artist::get( $name, '#', $description, Artist::listAlbum( @albums ) ); 
}

1;

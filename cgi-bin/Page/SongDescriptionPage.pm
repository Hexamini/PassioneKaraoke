use lib "cgi-bin";
use strict;

use Page::Object::SongDescription;
use Page::Object::SongVotes;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package SongDescriptionPage;

my $file = '../data/database/artistlist.xml'; 
my $fileUser = '../data/database/userlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id_artist ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_album ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my ( $id_song ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $node = $doc->findnodes( "//xs:artist[\@id='$id_artist']" )->get_node( 1 ); #nodo artist
    my $nameArtist = $node->findnodes( 'xs:nick/text()' );

    $node = $node->findnodes( "xs:album[\@id='$id_album']" )->get_node( 1 ); #nodo album
    my $nameAlbum = $node->findnodes( 'xs:name/text()' );

    $node = $node->findnodes( "xs:song[\@id='$id_song']" )->get_node( 1 ); #nodo song

    my $nameSong = $node->findnodes( 'xs:name/text()' );
    my $lyrics = $node->findnodes( 'xs:lyrics/text()' );
    my $url = $node->findnodes( 'xs:extra/text()' );

    $doc = ParserXML::getDoc( $parser, $fileUser );
    my $evaluate = 0;
    
    my @nodesEvaluate = $doc->findnodes( 
	"//xs:typeVote[\@idSong='$id_song' and \@idArtist='$id_artist' ".
	"and \@idAlbum='$id_album']" 
    );

    foreach my $node( @nodesEvaluate ) {
	$evaluate = $evaluate + $node->textContent();
    }

    my $user = Session::getSession();

    if ( $user ) {
	$node = $doc->findnodes( 
	    "//xs:user[\@username='$user']/xs:votes/xs:typeVote[\@idSong='$id_song' ".
	    "and \@idArtist='$id_artist' and \@idAlbum='$id_album']"
	)->get_node( 1 );

	my $songVotes = ( !$node ) ? 
	    SongVotes::get( $user, $id_artist, $id_album, $id_song ) :
	    SongVotes::messageConfirm();

	return SongDescription::get( 
	    $nameSong, 
	    $nameArtist, 
	    $id_artist, 
	    $nameAlbum, 
	    $lyrics, 
	    $url,
	    $evaluate,
	    $songVotes
	 );
    }
    
    return SongDescription::get( 
	$nameSong, 
	$nameArtist, 
	$id_artist, 
	$nameAlbum, 
	$lyrics, 
	$url,
	$evaluate 
    );
};

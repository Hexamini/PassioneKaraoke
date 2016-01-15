use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::UserPage;
use Page::Object::LikeSong;
use Page::Object::Base::ParserXML;

package UserPagePage;

my $fileSong = '../data/database/artistlist.xml';
my $fileUser = '../data/database/userlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $user ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my $docSong = ParserXML::getDoc( $parser, $fileSong );
    my $docUser = ParserXML::getDoc( $parser, $fileUser );

    my @nodeVotes = $docUser->findnodes( "//xs:user[\@username='$user']/xs:votes/xs:typeVote" );

    my @songs = ();
    
    foreach my $vote( @nodeVotes ) {
	my $idArtist = $vote->getAttribute( 'idArtist' );
	my $idAlbum = $vote->getAttribute( 'idAlbum' );
	my $idSong = $vote->getAttribute( 'idSong' );

	my $nodeArtist = $docSong->findnodes( "//xs:artist[\@id='$idArtist']" )->get_node( 1 );

	my $nickArtist = $nodeArtist->findnodes( 'xs:nick' );
	my $songTitle = $nodeArtist->findnodes( 
	    "/xs:album[\@id='$idAlbum']/xs:song[\@id='idSong']/xs:name/text()"
	);

	push( @songs, LikeSong::get( 
		  $idArtist, 
		  $idAlbum, 
		  $idSong, 
		  $songTitle, 
		  $nickArtist
	      ) );
    }

    @songs = reverse @songs;

    return UserPage::get( $user, UserPage::likeSong( @songs ) );
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::LastNews;
use Page::Object::LastSong;
use Page::Object::LastArticle;
use Page::Object::Index;
use Page::Object::Message;
use Page::Object::Base::ParserXML;

package IndexPage;

my $fileNews = '../data/database/news.xml';
my $fileSong = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_; 
    my $doc = ParserXML::getDoc( $parser, $fileNews );
    my $docSong = ParserXML::getDoc( $parser, $fileSong );

    my ( $flag ) = ( ( shift @pairs ) =~ /=(.*)/ );

    my @nodeSong = $doc->findnodes( '//xs:newSong' );
    my @nodeArticle = $doc->findnodes( '//xs:newArticle' );

    my @lastSongs = ();
    my @lastArticles = ();

    foreach my $newSong( @nodeSong )
    {
	my $idArtist = $newSong->getAttribute( 'artist' );
	my $idAlbum = $newSong->getAttribute( 'album' );
	my $idSong = $newSong->getAttribute( 'id' );

	my $nodeArtist = $docSong->findnodes( "//xs:artist[\@id='$idArtist']" )->get_node( 1 );

	my $nick = $nodeArtist->findnodes( 'xs:nick/text()' );
	my $song = $nodeArtist->findnodes( 
	    "xs:album[\@id='$idAlbum']/xs:song[\@id='$idSong']/xs:name/text()" 
	);

	push( @lastSongs, LastSong::get( 
		  $song,
		  $nick,
		  $idArtist,
		  $idAlbum,
		  $idSong
	      ) 
	 );
    }

    foreach my $newArticle( @nodeArticle )
    {
	push( @lastArticles, LastArticle::get(
		  ParserXML::getContent( $newArticle->findnodes( 'xs:title/text()' ) ),
		  ParserXML::getContent( $newArticle->findnodes( 'xs:subtitle/text()' ) ),
		  $newArticle->getAttribute( 'id' )
	      )
	    );
    }

    #Per usabilita' facciamo apparire le notize in ordine decrescente d'uscita
    @lastArticles = reverse @lastArticles;
    @lastSongs = reverse @lastSongs;

    my $lastArticle = LastNews::lastArticles( @lastArticles );
    my $lastSong = LastNews::lastSongs( @lastSongs );

    my $lastNews = LastNews::get( $lastSong, $lastArticle );

    if ( $flag eq 'confirm' ) {
	return Index::get( $lastNews, Message::get() );
    }

    return Index::get( $lastNews );
}

1;

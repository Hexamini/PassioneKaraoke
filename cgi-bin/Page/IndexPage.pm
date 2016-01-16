use lib "cgi-bin";
use strict;

use Page::Object::Categories;
use Page::Object::Category;
use Page::Object::LastNews;
use Page::Object::LastSong;
use Page::Object::LastArticle;
use Page::Object::Index;
use Page::Object::Base::ParserXML;

package IndexPage;

my $fileNews = '../data/database/news.xml';
my $fileCategory = '../data/database/category.xml';

sub get
{
    my ( $parser ) = @_; 
    my $doc = ParserXML::getDoc( $parser, $fileNews );

    my @nodeSong = $doc->findnodes( '//xs:newSong' );
    my @nodeArticle = $doc->findnodes( '//xs:newArticle' );

    my @lastSongs = ();
    my @lastArticles = ();

    foreach my $newSong( @nodeSong )
    {
	push( @lastSongs, LastSong::get( 
		  $newSong->findnodes( 'xs:song/text()' ),
		  $newSong->findnodes( 'xs:artist/text()' ),
		  $newSong->getAttribute( 'artist' ),
		  $newSong->getAttribute( 'album' ),
		  $newSong->getAttribute( 'id' ) 
	      ) 
	    );
    }

    foreach my $newArticle( @nodeArticle )
    {
	push( @lastArticles, LastArticle::get(
		  $newArticle->findnodes( 'xs:title/text()' ),
		  $newArticle->findnodes( 'xs:subtitle/text()' ),
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

    $doc = ParserXML::getDoc( $parser, $fileCategory );
    my @nodeCategory = $doc->findnodes( '//xs:category' );

    my @categories = ();

    foreach my $category( @nodeCategory )
    {
	push( @categories, $category->textContent );
    }
    
    my $categories = Categories::get( Categories::listCategory( @categories ) );

    return Index::get( $categories, $lastNews );
}

1;

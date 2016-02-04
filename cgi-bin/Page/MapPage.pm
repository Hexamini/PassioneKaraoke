use lib "cgi-bin";
use strict;
use warnings;
use XML::LibXML;

use Page::Object::Map;
use Page::Object::MapParent;
use Page::Object::MapList;
use Page::Object::Link;
use Page::Object::Base::Behavior;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package MapPage;

my $fileArtist = '../data/database/artistlist.xml';
my $fileArticle = '../data/database/articlelist.xml';

sub get {
    my ( $parser ) = @_;
    #==============================Artisti==================================

    my $doc = ParserXML::getDoc( $parser, $fileArtist ); #Parser artisti
    
    my @parents = ();

    push @parents, Behavior::rename(
	MapList::get( Link::get( 'Index', 'r.cgi?section=index' ) ),
	'mapList',
	'mapParent'
	);

    my @nodeArtists = $doc->findnodes( '//xs:artist' );
    my @childArists = ();
    foreach my $nodeArtist( @nodeArtists ) { #Scorro tutti gli artisti
	my @nodeAlbums = $nodeArtist->findnodes( 'xs:album' );
	my @childAlbums = ();

	my $idArtist = $nodeArtist->getAttribute( 'id' );
	my $nameArtist = $nodeArtist->findnodes( 'xs:name/text()' );
	foreach my $nodeAlbum( @nodeAlbums ) { #Scorro tutti i loro album
	    my @nodeSongs = $nodeAlbum->findnodes( 'xs:song' );
	    my @childSongs = ();

	    my $idAlbum = $nodeAlbum->getAttribute( 'id' );
	    my $nameAlbum = $nodeAlbum->findnodes( 'xs:name/text()' );
	    foreach my $nodeSong( @nodeSongs ) { #Scorro tutte le canzoni nell'album
		my $nameSong = $nodeSong->findnodes( 'xs:name/text()' );
		my $idSong = $nodeSong->getAttribute( 'id' );

		push @childSongs, MapList::get( 
		    Link::get(
			$nameSong,
			"r.cgi?section=songDescription&artist=$idArtist".
			"&album=$idAlbum&song=$idSong"
		    )
		);
	    }

	    my $parentAlbum = MapParent::get( $nameAlbum, MapParent::mapList( @childSongs ) );
	    push @childAlbums, Behavior::rename( $parentAlbum, 'mapParent', 'mapList' ); #Il padre diventa figlio
        }

	my $parentArtist = MapParent::get( 
	    Link::get( 
		$nameArtist,
		"r.cgi?section=artist&id=$idArtist"
	    ),
	    MapParent::mapList( @childAlbums )
	);
	push @childArtists, Behavior::rename( $parentArtist, 'mapParent', 'mapList' ); #Come sopra
    }

    push @parents, MapParent::get( #Creata albero artisti
	Link::get( 'Artisti', 'r.cgi?section=artists' ),
	MapParent::mapList( @childArtists )
    ); 

    #========================================================================
    #=============================Articoli===================================

    $doc = ParserXML::getDoc( $parser, $fileArticle ); #Parser articoli

    my @nodeArticles = $doc->findnodes( '//xs:article' );
    my @childrenArticle = ();
    foreach my $nodeArticle( @nodeArticles ) {
	my $idArticle = $nodeArticle->getAttribute( 'id' );
	my $title = $nodeArticle->findnodes( 'xs:title' );
	my $subtitle = $nodeArticle->findnodes( 'xs:subtitle' );

	push @childrenArticle, MapList::get(
	    Link::get(
		"$title - $subtitle",
		"r.cgi?section=article&id=$idArticle"
	    )
	);
    }

    push @parents, MapParent::get(
	Link::get( 'Articoli', 'r.cgi?section=articles' ),
	MapParent::mapList( @childrenArticle )
    );

    #========================================================================
    #==============================Login=====================================

    my $user = Session::getSession();
    my $mapLogin = '';
    
    if ( $user ) {
	$mapLogin = MapList::get( Link::get( $user, "r.cgi?section=userPage&id=$user" ) );
    } else {
	$mapLogin = MapList::get( Ling::get( 'Login', 'r.cgi?section=login' ) );
    }

    push @parents, Behavior::rename(
	$mapLogin,
	'mapList',
	'mapParent'
    );

    return Map::get( Map::mapParent( @parents ) );
}

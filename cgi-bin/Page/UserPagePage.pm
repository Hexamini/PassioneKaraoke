use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::UserPage;
use Page::Object::AdminTools;
use Page::Object::ArticleManager;
use Page::Object::ArtistManager;
use Page::Object::AlbumManager;
use Page::Object::AlbumManagerList;
use Page::Object::SongManager;
use Page::Object::CategoryManager;
use Page::Object::Base::ParserXML;

package UserPagePage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $user ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my $doc = ParserXML::getDoc( $parser, $file );

    my @node = $doc->findnodes( '/xs:artistList/xs:artist' );
    my @optSing = ();
    
    foreach my $artist( @node )
    {
	push( @optSing, AlbumManagerList::get( $artist->getAttribute( 'id' ),
					       $artist->findnodes( 'xs:nick/text()' ) ) 
	    );
    }

    my $albumM = AlbumManager::get( 'Insert', AlbumManager::optionArtists( @optSing ), 1 );
    my $articleM = ArticleManager::get( 1 );
    my $artistM = ArtistManager::get( 'Insert', 1 );
    my $songM = SongManager::get( 'Insert', 1 );
    my $categoryM = CategoryManager::get( 1 );

    my $adminTools = AdminTools::get( $articleM, $artistM, $albumM, $songM, $categoryM );

    return UserPage::get( $user, $adminTools );    
}

1;

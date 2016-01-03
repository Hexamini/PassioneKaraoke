use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::UserPage;
use Page::Object::AdminTools;
use Page::Object::ArticleManager;
use Page::Object::ArtistManager;
use Page::Object::AlbumManager;
use Page::Object::Base::ParserXML;

package UserPagePage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $user ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my $doc = ParserXML::getDoc( $parser, $file );

    my @node = $doc->findnodes( '/xs:artistList/xs:artist/xs:nick' );
    my @optSing = ();
    
    foreach my $nick( @node )
    {
	push( @optSing, $nick->textContent );
    }

    my $albumM = AlbumManager::get( 'Insert', AlbumManager::optionArtists( @optSing ), 1 );
    my $articleM = ArticleManager::get( 1 );
    my $artistM = ArtistManager::get( 'Insert', 1 );

    my $adminTools = AdminTools::get( $articleM, $artistM, $albumM );

    return UserPage::get( $user, $adminTools );    
}

1;

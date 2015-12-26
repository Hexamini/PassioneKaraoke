use lib "cgi-bin";
use strict;

use Page::Object::UserPage;
use Page::Object::AdminTools;
use Page::Object::ArticleManager;
use Page::Object::ArtistManager;
use Page::Object::AlbumManager;

package UserPagePage;

sub get
{
    my @optSing = ( 'Gian va', 'DIo', 'Gesu', 'Fantozzi' );
    my $albumM = AlbumManager::get( 'Insert', AlbumManager::optionArtists( @optSing ), 1 );
    my $articleM = ArticleManager::get( 1 );
    my $artistM = ArtistManager::get( 'Insert', 1 );

    my $adminTools = AdminTools::get( $articleM, $artistM, $albumM );
    return UserPage::get( 'ciccio pasticcio', $adminTools );    
}

1;

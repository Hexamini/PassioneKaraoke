use lib "cgi-bin";
use strict;

use Page::Object::AlbumManager;

package AlbumManagerPage;

sub get
{
    my @optSing = ( 'Gian va', 'DIo', 'Gesu', 'Fantozzi' );
    return AlbumManager::get( 'Edit', AlbumManager::optionArtists( @optSing ), 0 );
}

1;

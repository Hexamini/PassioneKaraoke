use lib "cgi-bin";
use strict;

use Page::Object::AlbumManager;
use Page::Object::AlbumManagerList;

package AlbumManagerPage;

sub get
{
    my @optSing = ( 'Gian va', 'DIo', 'Gesu', 'Fantozzi' );
    return AlbumManager::get( 'Edit', AlbumManager::optionArtists( @optSing ) );
}

1;

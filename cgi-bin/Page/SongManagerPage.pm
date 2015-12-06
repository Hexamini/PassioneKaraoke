use lib "cgi-bin";
use strict;

use Page::Object::SongManager;

package SongManagerPage;

sub get
{
    return SongManager::get( 'Edit' );
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::ArtistManager;

package ArtistManagerPage;

sub get
{
    return ArtistManager::get( 'Edit', 0 );
}

1;

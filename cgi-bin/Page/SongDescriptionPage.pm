use lib "cgi-bin";
use strict;

use Page::Object::SongDescription;

package SongDescriptionPage;

sub get
{
    return SongDescription::get( 'Faccietta Nera', 'Petrarca', 'Fascismo', 'Simpatica ed irriverente', 'Anche questa vuoi!?', 'Va a casa' );
}

1;

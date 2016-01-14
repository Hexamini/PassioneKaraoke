use lib "cgi-bin";
use strict;

use Page::Object::ArtistManager;

package ArtistManagerPage;

sub get
{
    my ( @pairs ) = @_;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $artistManager = '';

    if ( $mode == 'insert' ) {
	$artistManager = ArtistManager::get( $mode, 0 );
    } else {
	#Da aggiungere la compilazione dei campi in ArtistManager
    }

    return $artistManager;
}

1;

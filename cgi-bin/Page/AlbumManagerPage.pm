use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::AlbumManager;
use Page::Object::Base::ParserXML;

package AlbumManagerPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pair ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $idArtist ) = ( ( shift @pair ) =~ /=(.+)/ );
    my ( $mode ) = ( ( shift @pair ) =~ /=(.+)/ );
    
    my $albumManager = '';

    if ( $mode == 'insert' ) {
	$albumManager = AlbumManager::get( $idArtist );
    } else {
	#Sezione per la modifica
    }

    return $albumManager;
}

1;

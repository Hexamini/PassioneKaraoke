use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::ErrorList;
use Page::Object::BoxError;
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

    my @errors = ();

    while ( scalar @pair > 0 ) {
	push @errors, ErrorList::get( ( ( shift @pair ) =~ /=(.+)/ ) );
    }

    my $boxError = undef;

    if ( scalar @errors > 0 ) {
	$boxError = BoxError::get( BoxError::errorList( @errors ) );
    }
    
    my $artist = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:nick/text()" );
    my $albumManager = '';

    if ( $mode == 'insert' ) {
	$albumManager = AlbumManager::get( $idArtist, $artist, $boxError );
    } else {
	#Sezione per la modifica
    }

    return $albumManager;
}

1;

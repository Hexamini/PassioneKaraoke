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
    my $nameArtist = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:nick/text()" );
       
    my @optSing = ( $nameArtist );
        
    return AlbumManager::get( 'Edit', AlbumManager::optionArtists( @optSing ), 0 );
}

1;

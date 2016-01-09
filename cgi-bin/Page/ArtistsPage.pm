use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Artists;
use Page::Object::ArtistsList;
use Page::Object::EditButton;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package ArtistsPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my @nodes = $doc->findnodes( '//xs:artist' );
    my @artists = ();
    
    foreach my $node( @nodes )
    {
	my $name = $node->findnodes( 'xs:nick/text()' );
	my $id = $node->getAttribute( 'id' );
	push( @artists, ArtistsList::get( $name, $id, '#' ) );
    }

    my $user = Session::getSession();
    
    my $artistsPage = ( !Session::isAdmin( $user ) ) ? 
	Artists::get( Artists::artistsList( @artists ) ) :
	Artists::get( 
	    Artists::artistsList( @artists ), 
	    EditButton::get( 'section=artists' )
	);

    return $artistsPage;
}

1;

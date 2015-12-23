use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Artists;
use Page::Object::ArtistsList;
use Page::Object::Base::ParserXML;

package ArtistsPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my @nodes = $doc->findnodes( '//xs:nick' );
    my @artists = ();
    
    foreach my $node( @nodes )
    {
	my $name = $node->textContent;
	push( @artists, ArtistsList::get( $name, '#' ) );
    }

    return Artists::get( Artists::artistsList( @artists ) );
}

1;

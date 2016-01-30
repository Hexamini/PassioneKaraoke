use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Artists;
use Page::Object::ArtistsList;
use Page::Object::EditButton;
use Page::Object::ArtistManager;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package ArtistsPage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );
    
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my @nodes = $doc->findnodes( '//xs:artist' );
    my @artists = ();
    
    foreach my $node( @nodes )
    {
	my $name = $node->findnodes( 'xs:nick/text()' );
	my $id = $node->getAttribute( 'id' );
	( $mode eq 'edit' ) ? 
	    push( @artists, 
		  ArtistsList::get( 
		      $name, 
		      $id,
		      '#',
		      EditButton::get( 
			  "r.cgi?section=artistManager&amp;id=$id&amp;mode=modify",
			  '&#44', 
			  'modifyButton'
		      ),
		      EditButton::get( 
			  'remove_artist.cgi',
			  '&#45',
			  'removeButton',
			  "$id"
		      )
		   ) 
	    ) :
	    push( @artists, ArtistsList::get( $name, $id, '#' ) ) ;
    }

    @artists = reverse @artists;

    my $user = Session::getSession();
    my $artistsPage = '';
    
    if ( !Session::isAdmin( $user ) ) {
	$artistsPage = Artists::get( Artists::artistsList( @artists ) );
    } else {
	if ( $mode eq 'edit' ) {
	    $artistsPage = Artists::get( 
		Artists::artistsList( @artists ),
		EditButton::get( 
		    'r.cgi?section=artists&amp;mode=edit', 
		    'Sezione amministrativa', 
		    'editButton'
		),
		EditButton::get( 
		    'r.cgi?section=artistManager&amp;id=0&amp;mode=edit', 
		    '&#43', 
		    'addButton'
		)
	    );

	} else {

	    $artistsPage = Artists::get( 
		Artists::artistsList( @artists ),
		EditButton::get( 
		    'r.cgi?section=artists&amp;mode=edit',
		    'Sezione amministrativa',
		    'editButton'
		)
            );
	}
    }

    return $artistsPage;
}

1;

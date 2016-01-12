use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Articles;
use Page::Object::ArticleList;
use Page::Object::EditButton;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package ArticlesPage;

my $file = '../data/database/articlelist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my @nodes = $doc->findnodes( '/xs:articleList/xs:article' );
    my @articles = ();

    foreach my $node( @nodes )
    {
	my $title = $node->findnodes( 'xs:title/text()' );
	my $subtitle = $node->findnodes( 'xs:subtitle/text()' );
	
	push( @articles, ArticleList::get( $title, $subtitle ) );
    }

    @articles = reverse @articles;
    
    my $user = Session::getSession();
    my $articlesPage = '';

    if ( !Session::isAdmin( $user ) ) {
	$articlesPage = Articles::get( Articles::articlesList( @articles ) );
    } else {

	my $size = @pairs;
	my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

	if ( $size == 1 && $mode == 'edit' ) {

	    $articlesPage = Articles::get( 
		Articles::articlesList( @articles ),
		EditButton::get( 'section=articles', 'edit', 'Sezione amministrativa', 'editButton' ),
		EditButton::get( 'section=articleManager', 'insert', '&#43', 'addButton' )
	    );

	} else {

	    $articlesPage = Articles::get( 
		Articles::articlesList( @articles ),
		EditButton::get( 'section=articles', 'edit', 'Sezione amministrativa', 'editButton' )
            );
	}
    }

    return $articlePage;
}

1;

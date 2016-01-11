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
    my ( $parser ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my @nodes = $doc->findnodes( '/xs:articleList/xs:article' );
    my @articles = ();

    foreach my $node( @nodes )
    {
	my $title = $node->findnodes( 'xs:title/text()' );
	my $subtitle = $node->findnodes( 'xs:subtitle/text()' );
	
	push( @articles, ArticleList::get( $title, $subtitle ) );
    }

    my $user = Session::getSession();

    my $articlePage = ( !Session::isAdmin( $user ) ) ?
	Articles::get( Articles::articleList( @articles ) ) :
	Articles::get( 
	    Articles::articleList( @articles ),
	    EditButton::get( 'section=articles' )
	);

    return $articlePage;
}

1;

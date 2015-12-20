use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Articles;
use Page::Object::ArticleList;
use Page::Object::Base::ParserXML;

package ArticlesPage;

my $file = '../data/database/articlelist.xml';

sub get
{
    my ( $parser ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my @nodes = $doc->findnodes( '/xs:articleList/xs:article' );
    my @articles = ();

    my $length = @nodes;

    foreach my $node( @nodes )
    {
	my $title = $node->findnodes( 'xs:title' )->get_node( 1 )->textContent;
	my $subtitle = $node->findnodes( 'xs:subtitle' )->get_node( 1 )->textContent;
	
	push( @articles, ArticleList::get( $title, $subtitle ) );
    }

    return Articles::get( Articles::articleList( @articles ) );
}

1;

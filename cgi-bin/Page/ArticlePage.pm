use lib "cgi-bin";
use strict;
use CGI;
use XML::LibXML;

use Page::Object::Article;
use Page::Object::Base::ParserXML;

package ArticlePage;

my $file = '../data/database/articleList';

sub get
{
    my( $parser, @pairs ) = @_;
    
    my ( $id ) = ( ( shift @pairs ) =~ /=((\w|\d)+)$/ );
    my $doc = ParserXML::getDoc( $parser, $file );
    
    $article = $doc->findnodes( "//xs:article[\@id=$id]" )->get_node( 1 );

    if( $article )
    {
	return Article::get( $article->findnodes( 'xs:title' )->get_node( 1 )->textContent,
			     $article->findnodes( 'xs:subtitle' )->get_node( 1 )->textContent,
			     $article->findnodes( 'xs:author' )->get_node( 1 )->textContent,
			     $article->findnodes( 'xs:data' )->get_node( 1 )->textContent,
			     $article->findnodes( 'xs:content' )->get_node( 1 )->textContent );
    }
    else
    {
	#redirect to 404 page
	my $cgi = CGI->new;
	$cgi->redirect( 'tecnologie-web.studenti.math.unipd.it/~amantova/cgi-bin/r.cgi' ); 
    }
}

1;

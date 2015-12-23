use lib "cgi-bin";
use strict;
use CGI;
use XML::LibXML;

use Page::Object::Article;
use Page::Object::Base::ParserXML;

package ArticlePage;

my $file = '../data/database/articlelist.xml';

sub get
{
    my( $parser, @pairs ) = @_;
    
    my ( $id ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my $doc = ParserXML::getDoc( $parser, $file );
    
    my $article = $doc->findnodes( "//xs:article[\@id='$id']" )->get_node( 1 );

    if( $article )
    {
	return Article::get( $article->findnodes( 'xs:title/text()' ),
			     $article->findnodes( 'xs:subtitle/text()' ),
			     $article->findnodes( 'xs:author/text()' ),
			     $article->findnodes( 'xs:data/text()' ),
			     $article->findnodes( 'xs:content/text()' ) );
    }
    else
    {
	#redirect to 404 page
	my $cgi = CGI->new;
	$cgi->redirect( 'tecnologie-web.studenti.math.unipd.it/~amantova/cgi-bin/r.cgi' ); 
    }
}

1;

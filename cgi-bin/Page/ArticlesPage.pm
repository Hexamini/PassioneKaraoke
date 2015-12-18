use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Articles;
use Page::Object::ArticleList;

package ArticlesPage;

my $file = 'articleList.xml';

sub get
{
    my ( $parser ) = @_;

    my $article1 = ArticleList::get( 'Adamo', 'Coglie la frutta' );
    my $article2 = ArticleList::get( 'Ed Eva', 'Lo incula' );

    my @articles = ( $article1, $article2 );

    return Articles::get( Articles::articleList( @articles ) );
}

1;

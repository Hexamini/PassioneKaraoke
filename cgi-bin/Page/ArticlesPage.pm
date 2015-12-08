use lib "cgi-bin";
use strict;

use Page::Object::Articles;
use Page::Object::ArticleList;

package ArticlesPage;

sub get
{
    my $article1 = ArticleList::get( 'Adamo', 'Coglie la frutta' );
    my $article2 = ArticleList::get( 'Ed Eva', 'Lo incula' );

    my @articles = ( $article1, $article2 );

    return Articles::get( Articles::articleList( @articles ) );
}

1;

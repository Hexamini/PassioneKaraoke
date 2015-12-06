use lib "cgi-bin";
use strict;

use Page::Object::Utility::Behavior;

package Articles;

my $struct = 'articles';

sub get
{
    my ( $listaArticoli ) = @_;
    
    my $values = {
	articleList => $listaArticoli,
    };

    return Behavior::getChain( $struct, $values );
}


sub articleList
{
    my ( @articles ) = @_;
    my $list = '';
    
    for my $article( @articles )
    {
	$list = $list . $article->{ ArticleList::structName() };
    }

    return $list;
}

1;

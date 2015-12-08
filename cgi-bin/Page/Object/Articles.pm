use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;
use Page::Object::ArticleList;

package Articles;

my $struct = 'articles';

=Description
Parametri:
    listaArticoli = Rappresentazione di una lista di ArticleList
=cut
sub get
{
    my ( $listaArticoli ) = @_;
    
    my $values = {
	'articleList' => $listaArticoli,
    };

    return Behavior::getChain( $struct, $values );
}


sub articleList
{
    my ( @articles ) = @_;
    my $list = '';
    
    for my $article( @articles )
    {
	$list = $list . ArticleList::extractContent( $article );
    }

    return $list;
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;
use Page::Object::ArticleList;

package Articles;

my $struct = 'articles';

=Description
Parametri:
    listaArticoli = Rappresentazione di una lista di ArticleList
    editButton = Oggetto rappresentante un bottone per accedere alla modalita
                 edit
=cut
sub get
{
    my ( $listaArticoli, $editButton ) = @_;
    
    my $values = {
	'articleList' => $listaArticoli,
    };

    if( defined $editButton )
    {
	$values = Behavior::weld( $values, $editButton );
    }
    
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

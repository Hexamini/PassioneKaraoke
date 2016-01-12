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
    addButton = Oggetto rapprensetate un bottone per inserire l'articolo
=cut
sub get
{
    my ( $listaArticoli, $editButton, $addButton ) = @_;
    
    my $values = {
	'articleList' => $listaArticoli,
    };

    if( defined $editButton )
    {
	$values = Behavior::weld( $values, $editButton );

	if ( defined $addButton ) {
	    $values = Behavior::weld( $values, $addButton );
	}
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

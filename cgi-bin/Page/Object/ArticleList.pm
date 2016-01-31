use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ArticleList;

my $struct = 'articleList';

=Description
Parametri:
    titolo = Titolo articolo
    sottotitolo = Sottotitolo articolo
    id = Id dell'articolo
=cut
sub get
{
    my ( $titolo, $sottotitolo, $id, $modifyButton, $removeButton ) = @_;
    
    my $values = {
	'title' => $titolo,
	'subtitle' => $sottotitolo,
	'id' => $id,
    };

    if ( defined $modifyButton ) {
	$values = Behavior::weld( $values, $modifyButton );
    } if ( defined $removeButton ) {
	$values = Behavior::weld( $values, $removeButton );
    }

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent
{
    my ( $itemList ) = @_;
    return $itemList->{ $struct };
}

1;

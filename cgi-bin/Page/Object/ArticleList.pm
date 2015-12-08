use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package ArticleList;

my $struct = 'articleList';

=Description
Parametri:
    titolo = Titolo articolo
    sottotitolo = Sottotitolo articolo
=cut
sub get
{
    my ( $titolo, $sottotitolo ) = @_;
    
    my $values = {
	'title' => $titolo,
	'subtitle' => $sottotitolo,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub extractContent
{
    my ( $itemList ) = @_;
    return $itemList->{ $struct };
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LastArticle;

my $struct = 'lastArticle';

=begin
Parametri:
    articleName = Nome dell'articolo
    subtitle = Sottotitolo dell'articolo
    id = Id articolo
=cut
sub get
{
    my ( $articleName, $subtitle, $id ) = @_;

    my $values = {
	'articleName' => $articleName,
	'subtitle' => $subtitle,
	'id' => $id,
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

sub extractContent
{
    my ( $lastArticle ) = @_;
    return $lastArticle->{ $struct };
}

1;

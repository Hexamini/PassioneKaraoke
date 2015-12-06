use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package LastArticle;

my $struct = 'lastArticle';

=begin
Parametri:
    articleName = Nome dell'articolo
    shortText = Breve descrizione
=cut
sub get
{
    my ( $articleName, $shortText ) = @_;

    my $values = {
	'articleName' => $articleName,
	'shortText' => $shortText,	
    };

    return Behavior::getChain( $struct, $values, 1 );
}    

1;

use lib "cgi-bin";
use strict;

use Page::Object::BoxError;
use Page::Object::Base::Behavior;

package ArticleManager;

my $struct = 'articleManager';

=Description
Parametri:
    boxError = Oggetto rappresentante il riquadro degli errori commessi
=cut
sub get
{
    my ( $author, $date, $title, $subtitle, $content, $boxError ) = @_;

    my $values = {
	'author' => $author,
	'date' => $date,
	'title' => $title,
	'subtitle' => $subtitle,
	'content' => $content,
    };

    if ( defined $boxError ) {
	$values = Behavior::weld( $values, $boxError );
    }
    
    return Behavior::getChain( $struct, $values );
}

1;

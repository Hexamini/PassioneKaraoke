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
    my ( $id, $author, $date, $title, $subtitle, $content, $mode, $boxError ) = @_;

    my $values = {
	'id' => $id,
	'author' => $author,
	'date' => $date,
	'title' => $title,
	'subtitle' => $subtitle,
	'body' => $content,
	'mode' => $mode,
    };

    if ( defined $boxError ) {
	$values = Behavior::weld( $values, $boxError );
    }
    
    return Behavior::getChain( $struct, $values );
}

1;

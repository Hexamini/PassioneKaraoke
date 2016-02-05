use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package Link;

my $struct = 'link';

=Description
Paramentri:
    text = Testo del link
    link = url della pagina 
=cut
sub get {
    my ( $text, $link ) = @_;
    
    my $values = {
	'text' => $text,
	'link' => $link,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub noLink {
    my ( $title ) = @_;
    return { $struct => $title };
}

sub rename{
    my ( $link, $name ) = @_;

    return Behavior::rename( $link, $struct, $name );
}

1;

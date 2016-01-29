#!/usr/bin/perl -w
use strict;

use Page::Object::Base::Behavior;

package EditButton;

my $struct = 'editButton';

=Description
Parametri:
    section = Sezione da accedere in modalita' edit
=cut
sub get
{
    my ( $link, $value, $name, $args ) = @_;

    my $values = {
	'link' => $link,
	'args' => $args,
	'value' => $value,
    };

    my $button = Behavior::getChain( $struct, $values, 1 );
    
    if( defined $name ){
	$button = Behavior::rename( $button, $struct, $name );
    }

    return $button;
}

1;

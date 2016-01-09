#!/usr/bin/perl -w
use strict;

use Page::Object::Base::Behavior;

package EditButton;

my $struct = 'editButton';

=Description
Parametri:
    section = Indirizzo pagina corrente
=cut
sub get
{
    my ( $section ) = @_;

    my $values = {
	'page' => $section,
    };

    return Behavior::getChain( $struct, $values );
}

1;

#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;

use Page::Object::Base::Behavior;

package CategoryManager;

my $struct = 'categoryManager';

=Description
Parametri:
    content = Valore 1 se si desidera avere solo il contenuto, 0 per i meta 
              associati.
=cut
sub get
{
    my ( $content ) = @_;
    return Behavior::getChain( $struct, {}, $content );
}

use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package Frame;

my $struct = "frame";

=begin

=cut
sub get
{
    my ( $table, $lastNews ) = @_;

    my $fus = Behavior::weld( $table, $lastNews );
    return Behavior::getChain( $struct, $fus );
}

1;

use lib "cgi-bin";
use strict;

use Object::Utility::ParserHTML;

package LastNews;

my $struct = "lastNews";

=begin

=cut
sub get
{
    my ( $args ) = @_;
        
    my $tmp = ParserHTML::parsing( { filename => $struct, values => $args, } );
    my $chain = ParserHTML::ringChain( $tmp );

    # associa al contenuto una chiave intitolata come la stuttura 
    $chain->{ $struct } = delete $chain->{ 'content' };
    return $chain;
}

1;

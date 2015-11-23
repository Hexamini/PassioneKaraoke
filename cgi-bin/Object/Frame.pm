use lib "cgi-bin";
use strict;

use Object::Utility::ParserHTML;

package Frame;

my $struct = "frame";

=begin

=cut
sub get
{
    my ( $args ) = @_;

    my $fus = $args->{ table };
    my $lastNews = $args->{ lastNews };

    # sezione swap chiavi
    while( my ( $key, $value ) = each( %$lastNews ) )
    {
	# sezione collisione chiavi
	if( exists $fus->{ $key } )
	{
	    if( $key eq 'keywords' )
	    {
		$fus->{ $key } = $fus->{ $key } . ', ' . $value;
	    }
	}
	else
	{
	    $fus->{ $key } = $value;
	}
    }
    
    my $tmp = ParserHTML::parsing( { filename => $struct, values => $fus, } );
    my $chain = ParserHTML::ringChain( $tmp );

    # associa al contenuto una chiave intitolata come la stuttura 
    # $chain->{ $struct } = delete $chain->{ content };

    return $chain;
}

1;

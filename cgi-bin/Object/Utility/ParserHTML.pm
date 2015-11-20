use strict;
use autodie;
use Template;

package ParserHTML;

my $tt = Template->new({
    RELATIVE => 1,
    INCLUDE_PATH => "../data/views",
		       });

=begin 
Parametri:
-args = hash con le seguienti keyword:
    +filename = path del file html con la struttura;
    +values = hash con i valori dei segnaposti;

Scopo: Parsing del file html, sostiuisce i segnaposto con i valori contenuti in %values;

Ritorno: codice html della pagina;

TODO:
gestione errori:
-caso di meno definizioni di segnaposti 
-caso di piu' definizioni di segnaposti
=cut
sub parsing
{
    my ( $args ) = @_;

    my $temp = '';

    $tt->process( $args->{filename}, $args->{values}, \$temp ) || die $tt->error();
    return ringChain( $temp );
}


sub ringChain
{
    my ( $temp ) = @_;
     
    my @lines = split /\n/, $temp;
    my $process = 0;

    my %meta = ();
    
    if( $lines[ $process ] eq "!_META" )
    {
	$process = $process + 1;
	
	while( $lines[ $process ] ne "META_!" )
	{
	    if( ( substr $lines[ $process ], 0, 1 ) eq '\@' )
	    {
		#match pair ( meta, value )
		my @pair = split /=/, $lines[ $process ];
		
		print scalar @pair . "<br>";
		
		#solo le linee effettivamente riempite
		if( scalar @pair > 0 )
		{
		    $meta{ $pair[0] } = $pair[1];
		}
	    }
	    
	    $process = $process + 1;
	}
    }


    return $temp;
}

1;

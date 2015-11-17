use strict;
use Path::Class;
use autodie;

package ParserHTML;

#Estrapola la key del segnaposto
sub takeValue
{
     return ( $_[0] =~ /[^!_]+/g )[0];   
}

=begin 
Parsing del file html, sostiuisce i segnaposto con i valori contenuti in %values
e ritorna la pagina html.
TODO:
gestione errori:
-caso di meno definizioni di segnaposti 
-caso di piu' definizioni di segnaposti
=cut
sub parsingHTML
{
    my ($file_handle,%values) = @_;
    my $page;

    while( my $line = $file_handle->getline() )
    { 
	my @found = ( $line =~ /!_\w+_!/g );

	foreach my $word( @found )
	{
	    my $value = $values{ takeValue( $word ) };
	    $line =~ s/$word/$value/;
	}

	$page = $page . $line;
    }

    return $page;
}


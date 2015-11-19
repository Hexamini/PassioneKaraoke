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
Parametri:
-filename = path del file html con la struttura;
-values = hash con i valori dei segnaposti;

Scopo: Parsing del file html, sostiuisce i segnaposto con i valori contenuti in %values;

Ritorno: codice html della pagina;

TODO:
gestione errori:
-caso di meno definizioni di segnaposti 
-caso di piu' definizioni di segnaposti
=cut
sub parsing
{
    my ($filename,%values) = @_;
    my $page;
    
    open( my $file_handle, '<:encoding(UTF-8)', $filename )
	or die "Impossibile aprire il file $filename\n";
        
    while( my $line = <$file_handle> )
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

1;

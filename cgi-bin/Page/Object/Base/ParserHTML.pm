use strict;
use autodie;
use Template;

package ParserHTML;

my $tt = Template->new({
    RELATIVE => 1,
    INCLUDE_PATH => '../data/views',
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
    my $file = $args->{filename} . '.html';

    $tt->process( $file, $args->{values}, \$temp ) || die $tt->error();
    return $temp;
}


sub ringChain
{
    my ( $temp ) = @_;
     
    my @lines = split /\n/, $temp;
    my $process = 0; # linea processata

    my $ring = {};

    # Gestione dei meta tag
    if( $lines[ $process ] eq "!_META" ) # Riga d'intestazione
    {
	$process = $process + 1;
	
	while( $lines[ $process ] ne "META_!" ) # Riga di fine
	{
	    if( $lines[ $process ] =~ /(^@)(\w+)(\s*=\s*)(.*$)/g )
	    {
		# $2 => nome meta
		# $4 => valore
		# $1 => @ di identificazione meta
		# $3 => l'uguale, da usare solo se si vuole gestire gli errori
		$ring->{ $2 } = $4;
	    }
	    
	    $process = $process + 1;
	}

	$process = $process + 1; # salto la linea della chiusura dei meta
    }
    
    # splice restituisce tutto il contenuto rimasto, ovvero l'html della pagina.
    # Si crea l'array da dare la join la quale restituira' tutte le righe 
    # rimaste con alla fine lo \n per portarle a capo.   
    $ring->{ 'content' } = join( "\n", splice( @lines, $process, scalar @lines ) ); 
    return $ring;
}

1;

use strict;
use autodie;
use Template;

package ParserHTML;

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
    my $page = '';
    my $tt = Template->new({
	RELATIVE => 1,
	INCLUDE_PATH => "../data/views",
	OUTPUT => \$page,
    });

    my $values = {
	nome => 'Andrea',
	cognome => 'Mantovani',
	data => '17 settembre 1994',
	numero => '+393406936174',
    };

    $tt->process( 'table.html', $values ) || die $tt->error();
    return $page;
}

1;

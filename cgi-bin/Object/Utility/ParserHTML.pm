use strict;
use autodie;
use Template;

package ParserHTML;

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

    my $page = '';
    my $tt = Template->new({
	RELATIVE => 1,
	INCLUDE_PATH => "../data/views",
	OUTPUT => \$page,
    });

    $tt->process( $args->{filename}, $args->{values} ) || die $tt->error();
    return $page;
}

1;

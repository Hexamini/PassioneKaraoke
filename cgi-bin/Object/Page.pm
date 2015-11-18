use lib "cgi-bin"; #uso il mio package

package Page;

=begin
Ritorna il codice della pagina in formato HTML
Parametri
-hash con le seguenti key: body
=cut
sub getHTML
{
    my $struct = "data/page.html";

    my %values;
    $values{'body'} = $_[0] ;
        
    return ParserHTML::parsing( $struct, %values );
}

1;

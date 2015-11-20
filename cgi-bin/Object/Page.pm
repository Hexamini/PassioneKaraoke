use lib "cgi-bin"; #uso il mio package

package Page;

=begin
Visualizza la pagina html
Parametri
-hash con le seguenti key: body
=cut
sub display
{
    my ( $args ) = @_;
    my $struct = "frame.html";

    print ParserHTML::parsing({	filename => $struct, values => $args, });
}

1;

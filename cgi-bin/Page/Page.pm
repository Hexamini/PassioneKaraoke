use lib "cgi-bin"; #uso il mio package
use Page::Object::Base::Behavior;

package Page;

my $struct = "page";

=begin
Visualizza la pagina html
Parametri
-hash con le seguenti key: content
=cut
sub display
{
    my ( $chain ) = @_;

    print ParserHTML::parsing({ filename => $struct, values => $chain, });
}

sub collision
{
    my ( $meta, $rule ) = @_;
    Behavior::mngCollision( $meta, $rule );
}

1;

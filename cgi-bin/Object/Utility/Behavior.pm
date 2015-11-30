use lib "cgi-bin";
use strict;

use Object::Utility::ParserHTML;

package Behavior;

my %collider = ();

sub hello
{
    print "Hello";
}

=Description
Parametri:
    meta = meta da gestire la collisione
    rule = funzione da applicare nel caso di collisione
=cut
sub mngCollision
{
    my ( $meta, $rule ) = @_;
    
    $collider{ $meta } = $rule;
}

=Description
Parametri:
    ringChainA = href che funge da anello della catena A
    ringChainB = href che funge da anello della catena B

Tipo di ritorno: href

Scopo:
    Dati i due href, ritorna un href con tutte le coppie chiave, valore di A e
    B. Nel caso di collisione di chiavi viene applicato un algoritmo di colli-
    sione.
=cut
sub weld
{
    my ( $ringChainA, $ringChainB ) = @_;
    
    my $fusion = $ringChainA;

    # sezione swap chiavi
    while( my ( $key, $value ) = each( %$ringChainB ) )
    {
	$fusion->{ $key } = 
	    ( exists $fusion->{ $key } ) ? 
	    collision( $fusion->{ $key }, $value, $key ) :
	    $fusion->{ $key };
    }

    return $fusion;
}

=Description
Parametri:
    cA = contenuto A identificato con la chiave $key
    cB = contentuo B identificato con la chiave $key
    $key = valore chiave che identifica $cA e $cB

Risultato:
    Il tipo di cA e cB. Il valore dipende dal valore della chiave

Scopo:
    In caso di collisione qui si gestiscono i vari casi, senza appesantire la
    fusione weld.
=cut
sub collision
{
    my ( $cA, $cB, $key ) = @_;

    if( exists $collider{ $key } )
    {
	return $collider{ $key }( $cA, $cB );
    }
    else
    {
	#sostituizione 
	return $cA;
    }
}

=Description
Parametri: 
    struct = Nome della struttura. Verra' cercato in un file $struct.html
    values = href con i valori dei segnaposto
    retitle = variabile {0,1} per la rititolazione del contenuto

Tipo di ritorno: href;

Scopo:
    Ritorna l'href con tutti i meta della struttura ed il contenuto. Nel 
    caso retitle fosse true allora verrebbe usato il valore di $stuct come
    chiave.
=cut
sub getChain
{
    my ( $struct, $values, $retitle ) = @_; 

    my $tmp = ParserHTML::parsing( { filename => $struct, values => $values, } );
    my $chain = ParserHTML::ringChain( $tmp );

    if( $retitle )
    {
	$chain->{ $struct } = delete $chain->{ content };
    }

    return $chain;
}

1;

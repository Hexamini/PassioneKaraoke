use lib "cgi-bin";
use strict;

use Page::Object::Base::ParserHTML;

package Behavior;

my %collider = ();

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
	# sezione gestione collisioni
	$fusion->{ $key } = ( exists $fusion->{ $key } && 
			      exists $collider{ $key } ) ? 
	    $collider{ $key }( $fusion->{ $key }, $value ) : $value;
    }

    return $fusion;
}

sub rename
{
    my ( $chain, $oldName, $newName ) = @_;

    $chain->{ $newName } = delete $chain->{ $oldName };
    return $chain;
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
#	rename( $chain, 'content', $struct );
	$chain->{ $struct } = delete $chain->{ content };
    }

    return $chain;
}


1;







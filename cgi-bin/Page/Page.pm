use lib "cgi-bin"; #uso il mio package
use Page::Object::Base::Behavior;
use Page::Object::Base::Session;

package Page;

my $struct = "page";

=Description
Visualizza la pagina html
Parametri:
    chain = Catena di elementi html che compongono la pagina web
    section = Sezione corrente
=cut
sub display
{
    my ( $chain, $section ) = @_;
    
    my $user = Session::getSession();

    my $login = {
	'user' => 'Login',
	'ref_user' => 'section=login',
    };

    my $linkSections = {
	'index' => 'enable',
	'artists' => 'enable',
	'articles' => 'enable',
	'login' => 'enable',
    };

    if( $section )
    {
	$linkSections->{ $section } = 'disable';
    }
    
    if( $user )
    {
	$login->{ 'user' } = $user,
	$login->{ 'ref_user' } = "section=userPage&username=$user",
    }

    $chain = Behavior::weld( $chain, $login );
    $chain = Behavior::weld( $chain, $linkSections );
    
    print ParserHTML::parsing({ filename => $struct, values => $chain, });
}

sub collision
{
    my ( $meta, $rule ) = @_;
    Behavior::mngCollision( $meta, $rule );
}

1;

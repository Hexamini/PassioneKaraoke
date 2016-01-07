use lib "cgi-bin"; #uso il mio package
use Page::Object::Base::Behavior;
use Page::Object::Base::Session;

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
    
    my $user = Session::getSession();

    my $login = {
	'user' => 'User',
	'ref_user' => 'section=login',
    };
    
    if( $user )
    {
	$login->{ 'user' } = '$user',
	$login->{ 'ref_user' } = "section=userPage&user=$user",
    }

    $chain = Behavior::weld( $chain, $login );
    
    print ParserHTML::parsing({ filename => $struct, values => $chain, });
}

sub collision
{
    my ( $meta, $rule ) = @_;
    Behavior::mngCollision( $meta, $rule );
}

1;

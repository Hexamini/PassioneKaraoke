use lib "cgi-bin"; #uso il mio package

use Page::Object::Link;
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

    my %linkSections = (
	'index' => Link::get( '<span lang="en">Home</span>', 'r.cgi?section=index' ),
	'artists' => Link::get( 'Artisti', 'r.cgi?section=artists' ),
	'articles' => Link::get( 'Articoli', 'r.cgi?section=articles' ),
	'login' => Link::get( '<span lang="en">Login</span>', "r.cgi?section=login" ),
    );

    my %nameSections = (
	'index' => '<span lang="en">Home</span>', 
	'artists' => 'Artisti',
	'articles' => 'Articoli',
	'login' => '<span lang="en">Login</span>',
    );

    if ( $user ) {
	$linkSections{'login'} = Link::get( $user, "r.cgi?section=userPage&amp;id=$user" );
	$nameSections{'login'} = $user;
    }

    if( $section ) {
	$linkSections{ $section } = { 'link' => $nameSections{ $section } };
    }

    foreach my $key( keys %linkSections ) {
	$chain = Behavior::weld( 
	    $chain, 
	    Link::rename( $linkSections{$key}, $key )
	);
    }
    
    print ParserHTML::parsing({ filename => $struct, values => $chain, });
}

sub collision
{
    my ( $meta, $rule ) = @_;
    Behavior::mngCollision( $meta, $rule );
}

1;

use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::Base::Behavior;

my $struct = 'boxError';

=Description
Parametri:
    listError = Rappresentazione lista errori
=cut
sub get {
    my ( $listError ) = @_;

    my $values = {
	'listError' => $listError,
    };

    return Behavior::getChain( $struct, $values, 1 );
}


sub listError {
    my ( @errors ) = @_;
    my $list = '';

    foreach my $error( @errors ) {
	$list = $list . ErrorList::extractContent( $error );
    }

    return $list;
}

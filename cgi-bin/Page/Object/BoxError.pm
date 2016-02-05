use lib "cgi-bin";
use strict;

use Page::Object::ErrorList;
use Page::Object::Base::Behavior;

package BoxError;

my $struct = 'boxError';

=Description
Parametri:
    errorList = Rappresentazione lista errori
=cut
sub get {
    my ( $errorList ) = @_;

    my $values = {
	'errorList' => $errorList,
    };

    return Behavior::getChain( $struct, $values, 1 );
}


sub errorList {
    my ( @errors ) = @_;
    my $list = '';

    foreach my $error( @errors ) {
	$list = $list . ErrorList::extractContent( $error );
    }
    
    return $list;
}

1;

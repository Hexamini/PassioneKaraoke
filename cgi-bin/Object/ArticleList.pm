use lib "cgi-bin";
use strict;

use Object::Utility::Behavior;

package ArticleList;

my $struct = 'articleList';

sub get
{
    my ( $titolo, $sottotitolo ) = @_;
    
    my $values = {
	title => $titolo,
	subtitle => $sottotitolo,
    };

    return Behavior::getChain( $struct, $values, 1 );
}

sub structName
{
    return $struct;
}

1;

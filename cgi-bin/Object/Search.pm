use lib 'cgi-bin';
use strict;

use Object::Utility::Behavior;
use Object::SearchResult;

package Search;

my $struct = 'search';

=Description
Parametri:
    query = Stringa della query richiesta
    itemsFound = Numero elementi trovati
    searchResults = Lista dei risultati trovati
=cut
sub get
{
    my ( $query, $itemFound, $searchResults ) = @_;

    my $values = {
	query => $query,
	itemsFound => $itemFound,
	searchResults => $searchResults,
    };

    return Behavior::getChain( $struct, $values );
}

=Description
Parametri:
    results = Array contentenit SearchResult
=cut
sub searchResults
{
    my ( @results ) = @_;
    my $list = '';

    for my $result( @results )
    {
	$list = $list . $result->{ SearchResult::structName() } ;
    }

    return $list;
}

1;

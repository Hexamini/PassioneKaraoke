use lib "cgi-bin";
use strict;

use Page::Object::Search;
use Page::Object::SearchResult;

package SearchPage;

sub get
{
    my $result1 = SearchResult::get( 'http://www.mipiacitu.com', 'Nessuno e\' al sicuro', 'Ciao' );
    my $result2 = SearchResult::get( 'http://www.amoredio.com', 'Prega e sarai ripagato', 'Ciao' );
    my @results = ( $result1, $result2 );
    return Search::get( 'Maietti che passione', '10^15/23', Search::searchResults( @results ) );
}

1;
